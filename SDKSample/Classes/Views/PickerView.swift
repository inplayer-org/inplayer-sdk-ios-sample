//
//  PickerView.swift
//  SDKSample
//
//  Created by Oliver Dimitrov on 7/17/19.
//  Copyright © 2019 InPlayer. All rights reserved.
//

import UIKit

protocol PickerViewDataSource: class {
    func numberOfItems(inView: PickerView) -> Int
    func pickerView(_ pickerView: PickerView, titleForRow index: Int) -> String
}

protocol PickerViewDelegate: class {
    func onCancelPressed(_ pickerView: PickerView)
    func onDonePressed(_ pickerView: PickerView, selectedRow row: Int)
    func pickerView(_ pickerView: PickerView, didSelectRow row: Int)
}

class PickerView: UIView {

    weak var dataSource: PickerViewDataSource?
    weak var delegate: PickerViewDelegate?
    
    private var pickerView: UIPickerView
    
    init() {
        let frame = UIScreen.main.bounds
        
        let tintBackground = UIView(frame: frame)
        tintBackground.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        let placeholder = UIView(frame: CGRect(x: 0, y: frame.height - 270, width: frame.width, height: 270))
        placeholder.backgroundColor = .white
        
        let cancel = UIButton(frame: CGRect(x: 20, y: 8, width: 60, height: 30))
        cancel.setTitle("Cancel", for: .normal)
        cancel.setTitleColor(.black, for: .normal)
        
        let done = UIButton(frame: CGRect(x: frame.width - 80, y: 8, width: 60, height: 30))
        done.setTitle("Done", for: .normal)
        done.setTitleColor(.black, for: .normal)
        
        pickerView = UIPickerView(frame: CGRect(x: 0, y: done.frame.maxY, width: frame.width, height: 216))
        
        super.init(frame: frame)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        cancel.addTarget(self, action: #selector(self.onCancelPressed), for: .touchUpInside)
        done.addTarget(self, action: #selector(self.onDonePressed), for: .touchUpInside)
        
        addSubview(tintBackground)
        addSubview(placeholder)
        placeholder.addSubview(cancel)
        placeholder.addSubview(done)
        placeholder.addSubview(pickerView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCancelPressed))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = false
        tintBackground.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectRow(row: Int, animated: Bool) {
        pickerView.selectRow(row, inComponent: 0, animated: animated)
    }
    
    @objc private func onCancelPressed() {
        delegate?.onCancelPressed(self)
    }
    
    @objc private func onDonePressed() {
        delegate?.onDonePressed(self, selectedRow: pickerView.selectedRow(inComponent: 0))
    }
}

extension PickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerView(self, didSelectRow: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource?.pickerView(self, titleForRow: row)
    }
}

extension PickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource?.numberOfItems(inView: self) ?? 0
    }
}

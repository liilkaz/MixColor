//
//  ViewController.swift
//  MixColor
//
//  Created by Лилия Феодотова on 02.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //elements
    let stack = UIStackView(axis: .vertical, spacing: 0)
    
    let firstColorBox = ColorView()
    let secondColorBox = ColorView()
    let mixColor = ColorView()
    let plus = CharactersView(label: "+")
    let result = CharactersView(label: "=")
    
    let segmentControllLocalize = UISegmentedControl(items: ["ru", "en"])
    
    //colorPicker&selectedColor
    let firstColorPicker = UIColorPickerViewController()
    let secondColorPicker = UIColorPickerViewController()
    
    var firstSelectedColor = UIColor.gray
    var secondSelectedColor = UIColor.black
    
    let preferLocalisation = Bundle.main.preferredLocalizations[0]
    
    //lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupViewAction(colorView: firstColorBox)
        setupViewAction(colorView: secondColorBox)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        segmentControllLocalize.addTarget(self, action: #selector(localizedChange), for: .valueChanged)
    }
    
    func setupView() {
        
        stack.distribution = .fillProportionally
        view.addSubviews(stack)
        stack.addArrangedSubviews(firstColorBox, plus, secondColorBox, result, mixColor)
        stack.addSubviews(segmentControllLocalize)
        
        firstColorBox.configureView(color: firstSelectedColor)
        secondColorBox.configureView(color: secondSelectedColor)
        mixColor.configureView(color: blend(colors: [firstSelectedColor, secondSelectedColor]))
        
        segmentControllLocalize.selectedSegmentIndex = preferLocalisation == "ru" ? 0 : 1
        
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            segmentControllLocalize.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            segmentControllLocalize.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 30),
            segmentControllLocalize.heightAnchor.constraint(equalToConstant: 30),
            segmentControllLocalize.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setupViewAction(colorView: ColorView) {
        if colorView == firstColorBox {
            let gesture1 = UITapGestureRecognizer(target: self, action: #selector(presentColorPicker1))
            colorView.addGestureRecognizer(gesture1)
        } else {
            let gesture2 = UITapGestureRecognizer(target: self, action: #selector(presentColorPicker2))
            colorView.addGestureRecognizer(gesture2)
        }
    }
    
    @objc func localizedChange(_ target: UISegmentedControl) {
        if target == self.segmentControllLocalize {
            let index = target.selectedSegmentIndex
            let selectedLang = index == 0 ? "ru" : "en"
            print("select: ", selectedLang)
            print("lang of app: ", preferLocalisation)
            
            UserDefaults.standard.set([selectedLang], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
        }
        
        
    }

}

extension ViewController: UIColorPickerViewControllerDelegate {
    
    @objc func presentColorPicker1(_ sender: UITapGestureRecognizer) {
        firstColorPicker.delegate = self
        firstColorPicker.modalPresentationStyle = .popover
        present(firstColorPicker, animated: true)
    }
    
    @objc func presentColorPicker2(_ sender: UITapGestureRecognizer) {
        secondColorPicker.delegate = self
        secondColorPicker.modalPresentationStyle = .popover
        present(secondColorPicker, animated: true)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        if viewController === firstColorPicker {
            firstSelectedColor = viewController.selectedColor
            firstColorBox.configureView(color: firstSelectedColor)
        } else if viewController === secondColorPicker {
            secondSelectedColor = viewController.selectedColor
            secondColorBox.configureView(color: secondSelectedColor)
        }
        
        mixColor.configureView(color: blend(colors: [firstSelectedColor, secondSelectedColor]))
    }
    
    func blend(colors: [UIColor]) -> UIColor {
        let numberOfColors = CGFloat(colors.count)
        var (red, green, blue, alpha) = (CGFloat(0), CGFloat(0), CGFloat(0), CGFloat(0))

        let componentsSum = colors.reduce((red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat())) { temp, color in
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            return (temp.red+red, temp.green + green, temp.blue + blue, temp.alpha+alpha)
        }
        return UIColor(red: componentsSum.red / numberOfColors,
                           green: componentsSum.green / numberOfColors,
                           blue: componentsSum.blue / numberOfColors,
                           alpha: componentsSum.alpha / numberOfColors)
    }
}

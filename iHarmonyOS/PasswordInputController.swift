//
//  PasswordInputController.swift
//  iHarmonyOS
//
//  Created by Cyandev on 2021/6/5.
//

import UIKit

class PasswordInputController: UIViewController {

    var completionHandler: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "输入密码"
        
        navigationItem.rightBarButtonItem = .init(title: "取消", style: .plain, target: self, action: #selector(cancel))
        
        view.backgroundColor = .systemGroupedBackground

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.text = "请输入密码"
        view.addSubview(label)
        
        let field = PasswordField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.changeHandler = { [unowned self] in
            if field.textLength >= 6 {
                self.presentingViewController?.dismiss(animated: true, completion: {
                    self.completionHandler?()
                })
            }
        }
        view.addSubview(field)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 163),
            
            field.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            field.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24)
        ])
        
        DispatchQueue.main.async {
            field.becomeFirstResponder()
        }
    }
    
    @objc func cancel() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

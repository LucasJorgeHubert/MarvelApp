import Foundation
import UIKit

var vToast : UIView?

enum toastType {
    case success
    case alert
    case error
}

extension UIViewController {
    func showToast(text: String, type: toastType, onView : UIView) {
        let toastView = UIView.init(frame: onView.bounds)
        toastView.layer.cornerRadius = 8
        
        let text: UILabel = {
            let lb = UILabel()
            lb.textColor = .systemBackground
            lb.text = text
            lb.numberOfLines = 0
            lb.lineBreakMode = .byClipping
            return lb
        }()
        
        var icon: UIImageView = {
            let img = UIImageView()
            return img
        }()
        
        switch type {
            case .success:
                toastView.backgroundColor = .systemGreen
                icon = UIImageView(image: UIImage(systemName: "checkmark.seal"))
                icon.tintColor = .systemBackground
            case .error:
                toastView.backgroundColor = .systemRed
                icon = UIImageView(image: UIImage(systemName: "xmark.octagon"))
                icon.tintColor = .systemBackground
            case .alert:
                toastView.backgroundColor = .systemYellow
                icon = UIImageView(image: UIImage(systemName: "exclamationmark.triangle"))
                icon.tintColor = .systemBackground
        }
        
        toastView.addSubview(icon)
        toastView.addSubview(text)
        onView.addSubview(toastView)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            toastView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            toastView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            icon.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16),
            icon.centerYAnchor.constraint(equalTo: toastView.centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24),
            
            text.centerYAnchor.constraint(equalTo: toastView.centerYAnchor),
            text.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
            text.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: 16),
            text.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 8),
            text.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -8)
        ])
        
        DispatchQueue.main.async {
            vToast = toastView
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                toastView.removeFromSuperview()
                vToast = nil
            }
        }
    }
    
}

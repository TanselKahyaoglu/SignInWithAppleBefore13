# Sign in with Apple Framework before iOS 13

## About The Project

This framework allows you to use Sign in with Apple before iOS 13. It uses <a href="https://developer.apple.com/documentation/sign_in_with_apple/sign_in_with_apple_js/incorporating_sign_in_with_apple_into_other_platforms">Incorporating Sign in with Apple into Other Platforms</a> guides from Apple. This framework can only get a single-use authorization code. So, you should do all other operations on your application server. You can use this framework as a submodule.

## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

- iOS 9+

### Installation

1. Create folder on your project

2. Add submodule to project and clone

```sh
git submodule add https://github.com/TanselKahyaoglu/SignInWithAppleBefore13/
```

3. Add  SignInWithAppleBefore13.xcodeproj to project

4. Add SignInWithAppleBefore13.framework to Frameworks

### Use

It is very easy to use framework. You can use SignInWithAppleButton class on your project.
You can add a button to your storyboard or xib file and make it's class to SignInWithAppleButton 
or you can add from code with using SignInWithAppleButton() constructor.

- Configuration Button

Before you set configuration to button, you should get client_id and redirect_uri from developer.apple.com

For getting client_id and uri,

  - Enter developer.apple.com account and navigate to identifiers.
  - Select ServiceIds on button on right-top of page (default value is AppIds)
  - Create new service id for Sign in with Apple with redirect_uri and client id.
  - Add them to configuration struct and pass it to button with following code.

```sh
     let configuration = SignInWithAppleConfiguration(clientId: "yourclientid",
                                                      redirectUri: "http://yourredirecturi.com")
     btnSignInWithAppleBefore13.setConfiguration(configuration)
```
- Listening Actions

  - You can listen results with following code.

```sh
 btnSignInWithAppleBefore13.onCompletion = { [weak self] result in
            switch result {
            case .Success(let code):
                print(code)
                break
            case .Failed:
                print("Failed")
                break
            case .Cancelled:
                print("Cancelled")
                break
            }
        }
```

- Optional - Style of Button
Also, you can change style of button from storyboard/xib with style parameter.

Or buttonStyle
```sh
    btnSignInWithAppleBefore13.buttonStyle = .White
```

<!-- TODO -->
## ToDo

- Localization is missing.
- Scopes is missing. (Because of WkWebView)

<!-- CONTRIBUTING -->
## Contributing

I'm really open for contributing. We can make this project great together. 

 - Fork the project

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/MyFeature`)
3. Commit your Changes (`git commit -m 'Add some MyFeature'`)
4. Push to the Branch (`git push origin feature/MyFeature`)
5. Open a Pull Request

  - Or <p><a href="mailto:tansel.kahyaoglu@gmail.com">Mail me</a></p>

<!-- Resources -->
## Resources

  https://developer.apple.com
  https://developer.apple.com/documentation/sign_in_with_apple/sign_in_with_apple_js/incorporating_sign_in_with_apple_into_other_platforms
  https://developer.apple.com/documentation/sign_in_with_apple/sign_in_with_apple_rest_api/verifying_a_user
  https://developer.apple.com/documentation/sign_in_with_apple/generate_and_validate_tokens

<!-- LICENSE -->
## License

Distributed under the GPL License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Tansel Kahyaoğlu
<p><a href="mailto:tansel.kahyaoglu@gmail.com">Mail</a></p>
<p><a href="https://linkedin.com/in/tanselkahyaoglu">Linkedin</a></p>

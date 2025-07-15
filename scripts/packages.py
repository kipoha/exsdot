from runner import configure

from dev import install as install_dev

from main_packages import install as install_main


def main():
    try:
        yay_choice = input("Install AUR? (y/N): ").strip().lower()
        yay_packages_choice = input("Install AUR packages? (y/N): ").strip().lower()
        dev_choice = input("Install dev packages? (y/N): ").strip().lower()

        configure_choice = input("Your old configuration will be lost. Do you want to configure? (y/N): ").strip().lower()
        
        install_main(yay=yay_choice == "y", yay_packages=yay_packages_choice == "y")
        if dev_choice == "y":
            install_dev(yay_packages=yay_packages_choice == "y")

        if configure_choice == "y":
            configure()

        print("Done!")

    except KeyboardInterrupt:
        pass

if __name__ == "__main__":
    main()

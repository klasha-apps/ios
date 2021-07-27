import Foundation
import Swinject
import SwinjectAutoregistration


extension Container {

    static let sharedContainer:Container = {
        let container  = Container()
        
        container.autoregister(KlashaCardClient.self, initializer: KlashaCardClient.init)
        container.autoregister(KlashaBankClient.self, initializer: KlashaBankClient.init)
        container.autoregister(KlashaWalletClient.self, initializer: KlashaWalletClient.init)
        container.autoregister(KlashaMpesaClient.self, initializer: KlashaMpesaClient.init)

       //REPOSITORIES

        container.autoregister(PaymentServicesRepository.self, initializer: PaymentServicesRepositoryImpl.init)

        container.autoregister(MobileMoneyRepository.self, initializer: MobileMoneyRepositoryImpl.init)
        
        container.autoregister(BankRepository.self, initializer: BankRepositoryImpl.init)


       //VIEWMODELS

        container.autoregister(PaymentServicesViewModel.self, initializer: PaymentServicesViewModel.init)

         container.autoregister(BankViewModel.self, initializer: BankViewModel.init)
        
         container.autoregister(MobileMoneyViewModel.self, initializer: MobileMoneyViewModel.init)
        
        return container
    }()
}




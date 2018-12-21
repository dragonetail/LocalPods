public final class AssemblyFactory:
    CameraAssemblyFactory,
    MediaPickerAssemblyFactory,
    PhotoLibraryAssemblyFactory,
    ImageCroppingAssemblyFactory,
    MaskCropperAssemblyFactory
{
    
    private let theme: PaparazzoUITheme
    private let serviceFactory: ServiceFactory
    
    public init(
        theme: PaparazzoUITheme = PaparazzoUITheme(),
        imageStorage: ImageStorage = ImageStorageImpl())
    {
        self.theme = theme
        self.serviceFactory = ServiceFactoryImpl(imageStorage: imageStorage)
    }
    
    func cameraAssembly() -> CameraAssembly {
        return CameraAssemblyImpl(theme: theme, serviceFactory: serviceFactory)
    }
    
    public func mediaPickerAssembly() -> MediaPickerAssembly {
        return MediaPickerAssemblyImpl(
            assemblyFactory: self,
            theme: theme,
            serviceFactory: serviceFactory
        )
    }

    func imageCroppingAssembly() -> ImageCroppingAssembly {
        return ImageCroppingAssemblyImpl(theme: theme, serviceFactory: serviceFactory)
    }

    public func photoLibraryAssembly() -> PhotoLibraryAssembly {
        return PhotoLibraryAssemblyImpl(theme: theme, serviceFactory: serviceFactory)
    }
    
    public func maskCropperAssembly() -> MaskCropperAssembly {
        return MaskCropperAssemblyImpl(theme: theme, serviceFactory: serviceFactory)
    }
}

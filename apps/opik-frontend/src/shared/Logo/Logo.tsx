import React from "react";
import { cn } from "@/lib/utils";
import { useTheme } from "@/contexts/theme-provider";
import { THEME_MODE } from "@/constants/theme";
import imageLogoUrl from "/images/opik-logo.png";
import imageLogoInvertedUrl from "/images/opik-logo-inverted.png";

type LogoProps = {
  expanded: boolean;
};

const Logo: React.FunctionComponent<LogoProps> = ({ expanded }) => {
  const { themeMode } = useTheme();
  
  const logoSrc = themeMode === THEME_MODE.DARK ? imageLogoInvertedUrl : imageLogoUrl;

  if (!expanded) {
    return (
      <img
        className="h-[18px] w-[18px] object-cover object-left"
        src={logoSrc}
        alt="Moderator logo"
      />
    );
  }
  
  return (
    <div className="flex items-center gap-2">
      <img
        className="h-[18px] w-[18px] object-cover object-left"
        src={logoSrc}
        alt="Moderator logo"
      />
      <span className="font-bold text-lg leading-none tracking-tight">
        Moderator
      </span>
    </div>
  );
};

export default Logo;

# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/app-editors/gtk-xemacs/gtk-xemacs-21.1.12_p3.ebuild,v 1.3 2000/10/29 20:36:58 achim Exp
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish-themes/sawfish-themes-0.0.1.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Some nice themes for sawfish"

SRC_URI="http://ftp1.sourceforge.net/pub/mirrors/themes.org/sawmill/Adept-0.28.tar.gz
	 http://ftp1.sourceforge.net/pub/mirrors/themes.org/sawmill/Eazel-blue-0.30.tar.gz"
	 
HOMEPAGE="http://www.themes.org"

DEPEND="=x11-wm/sawfish-0.38"

src_install() {                               
  version=0.38
  
  dodir /usr/X11R6/share/sawfish/${version}/themes
  
  cd ${D}/usr/X11R6/share/sawfish/${version}/themes

  unpack Adept-0.28.tar.gz
  unpack Eazel-blue-0.30.tar.gz

}








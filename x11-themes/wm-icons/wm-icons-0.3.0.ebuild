# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/wm-icons/wm-icons-0.3.0.ebuild,v 1.1 2003/09/01 20:49:05 taviso Exp $

inherit gnuconfig 

DESCRIPTION="A Large Assortment of Beutiful Themed Icons, Created with FVWM in mind"

HOMEPAGE="http://wm-icons.sourceforge.net/"
SRC_URI="mirror://sourceforge/wm-icons/wm-icons-${PV}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~alpha"

IUSE=""
DEPEND=">=sys-apps/gawk-3
	>=dev-lang/perl-5.8.0"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	sed -i 's#$(bindir)/wm-icons-config#true#g' ${S}/Makefile.in
	use alpha && gnuconfig_update
}

src_compile() {
	econf --enable-all-sets --enable-icondir=/usr/share/icons/wm-icons
	emake
}

src_install() {
	# strange makefile...
	einstall icondir=${D}/usr/share/icons/wm-icons DESTDIR=${D}
	
	dodir /usr/bin
	mv ${D}/${D}/usr/bin/wm-icons-config ${D}/usr/bin/wm-icons-config
	rm -rf ${D}/${D}/usr/bin
	
	einfo "Setting default aliases..."
	${D}/usr/bin/wm-icons-config --user-dir="${D}/usr/share/icons/wm-icons" --defaults
	
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}

pkg_postinst() {
	einfo "Users can use the wm-icons-config utility to create aliases in their"
	einfo "home directory, FVWM users can then set this in their ImagePath"
	einfo
	einfo "Sample configurations for fvwm1, fvwm2, fvwm95 and scwm are available in"
	einfo "/usr/share/wm-icons"
	einfo
}

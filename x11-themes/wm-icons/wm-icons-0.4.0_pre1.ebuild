# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/wm-icons/wm-icons-0.4.0_pre1.ebuild,v 1.3 2003/12/17 20:51:31 taviso Exp $

inherit gnuconfig

DESCRIPTION="A Large Assortment of Beutiful Themed Icons, Created with FVWM in mind"

HOMEPAGE="http://wm-icons.sourceforge.net/"
SRC_URI="mirror://gentoo/wm-icons-${PV}-cvs-01092003.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 alpha"

IUSE=""
RDEPEND=">=sys-apps/gawk-3
	>=dev-lang/perl-5.8.0"
DEPEND="${DEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-apps/sed"

S=${WORKDIR}/wm-icons

src_unpack() {
	unpack ${A}

	sed -i 's#$(bindir)/wm-icons-config#true#g' ${S}/Makefile.am
	use alpha && gnuconfig_update
}

src_compile() {
	ebegin "Generating configure script, Please wait..."
	(	aclocal
		autoheader
		automake --add-missing
		autoreconf ) 2>/dev/null
	eend $?

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

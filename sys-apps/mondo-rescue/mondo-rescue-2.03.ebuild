# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mondo-rescue/mondo-rescue-2.03.ebuild,v 1.4 2004/10/19 13:43:26 vapier Exp $

inherit libtool

DESCRIPTION="A program which a Linux user can utilize to create a rescue/restore CD/tape."
HOMEPAGE="http://www.mondorescue.org/"
SRC_URI="http://www.microwerks.net/~hugo/download/MondoCD/TGZS/${PN/-rescue/}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/slang-1.4.1
	>=dev-libs/newt-0.50"
RDEPEND="app-arch/afio
	sys-apps/buffer
	sys-devel/binutils
	>=app-arch/bzip2-0.9
	app-cdr/cdrtools
	>=sys-apps/mindi-1.03
	>=dev-libs/newt-0.50
	>=sys-libs/slang-1.4.1
	>=sys-boot/syslinux-1.52"

S=${WORKDIR}/${PN/-rescue/}-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	chmod 750 configure
}

src_compile() {
	elibtoolize
	econf || die "Configuration failed"
	emake || die "Make failed"
}

src_install() {
	#make install DESTDIR=${D} || die "make install failed"
	einstall || die "Install failed"
	exeinto /usr/share/mondo
	doexe mondo/autorun
}

pkg_postinst() {
	einfo "${P} was successfully installed."
	einfo "Please read the associated docs for help."
	einfo "Or visit the website @ ${HOMEPAGE}"
	echo
	ewarn "This package is still in unstable."
	ewarn "Please report bugs to http://bugs.gentoo.org/"
	ewarn "However, please do an advanced query to search for bugs"
	ewarn "before reporting. This will keep down on duplicates."
	echo
	einfo "Prior to running mondo, ensure /boot is mounted."
	ewarn "Grub users need to have a symlink like this:"
	ewarn "ln -s /boot/grub/menu.lst /etc/grub.conf"
	einfo "Unless you want to have mondo backup your distfiles,"
	einfo "append \"-E ${DISTDIR}\" to your mondoarchive command."
	echo
}

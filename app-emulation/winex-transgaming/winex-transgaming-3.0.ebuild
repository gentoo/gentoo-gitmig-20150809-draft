# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/winex-transgaming/winex-transgaming-3.0.ebuild,v 1.2 2003/05/06 09:52:08 lordvan Exp $

IUSE="cups opengl"

MY_P="winex3_${PV}-1.i386"
DESCRIPTION="WineX is a distribution of Wine with enhanced DirectX for gaming"
HOMEPAGE="http://www.transgaming.com/"

SLOT="3"
KEYWORDS="~x86"
LICENSE="Aladdin"

RDEPEND="virtual/x11
	opengl? ( virtual/opengl )
	>=sys-libs/ncurses-5.2
	cups? ( net-print/cups )
	>=media-libs/freetype-2.0.0
	!app-emulation/winex"
        

src_unpack () {
	if [ ! -e "${DISTDIR}/${MY_P}.tgz" ] ; then
		eerror ""
		eerror "Please download the appropriate WineX archive (${MY_P}.tgz)"
		eerror "from: ${HOMEPAGE} (requires a Transgaming subscription)."
		eerror ""
		eerror "The archive should be placed into ${DISTDIR}."
		eerror ""

		die "package archive (${MY_P}.tgz) not found"
	fi
	unpack "${MY_P}.tgz"
}

src_install () {
	mv "${WORKDIR}/usr" "${D}"
}

pkg_postinst() {
	einfo "Run /usr/bin/winex3 to start winex as any non-root user."
	einfo "This is a wrapper-script which will take care of creating"
	einfo "an initial environment and do everything else."
	einfo ""
	einfo "Optionally, if you have binfmt_misc compiled into your kernel,"
	einfo "you can add the following to /etc/sysctl.conf to allow direct"
	einfo "excecution of Windows binaries through the winex wrapper:"
	einfo ""
	einfo "  fs.binfmt_misc.register = :WINEXE:M::MZ::/usr/bin/winex:"
	einfo ""
	einfo "You will also need to mount the /proc/sys/fs/binfmt_misc"
	einfo "file system in order for this to work.  You can add the following"
	einfo "line into your /etc/fstab file:"
	einfo ""
	einfo "  none  /proc/sys/fs/binfmt_misc  binfmt_misc  defaults 0 0"
	einfo ""
	einfo "Note: Binaries will still need excecutable permissions to run."
	einfo "Note: If binfmt_misc is compiled as a module, make sure you"
	einfo "have it loaded on startup by adding it to /etc/modules.autoload."
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/peercast/peercast-0.1211.ebuild,v 1.1 2004/10/07 18:48:49 trapni Exp $

DESCRIPTION="A client and server for Peercast P2P-radio network"
HOMEPAGE="http://www.peercast.org"

# as the official peercast download site does *NOT* provide
# versioned URLs we must provide a seperated download URL where
# we can downlaod this (versioned).
SRC_URI="http://dev.gentoo.org/~trapni/dist/${PN}-linux-${PV}.tgz"

LICENSE="freedist"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

RDEPEND="
	amd64? ( app-emulation/emul-linux-x86-baselibs )
"

S=${WORKDIR}

src_compile() {
	(
		echo "#! /bin/sh"
		echo ""
		if use amd64 &> /dev/null; then
			echo "GCC_VERSION=\$(gcc-config -c)"
			echo "export LD_LIBRARY_PATH=/lib32:/emul/linux/x86/usr/lib/gcc-lib/\${GCC_VERSION/gnu-/gnu/}"
		fi
		echo "cd /opt/peercast"
		echo "exec ./peercast \"\$@\""
	) > peercast.sh
}

src_install() {
	exeinto /opt/peercast
	doexe peercast

	cp -R html ${D}/opt/peercast/

	into /opt
	newbin peercast.sh peercast

	exeinto /etc/init.d
	newexe ${FILESDIR}/peercast.init peercast
}

pkg_postinst() {
	einfo
	einfo

	einfo "Start Peercast with '/etc/init.d/peercast start' and point your"
	einfo "webbrowser to 'http://localhost:7144' to start using Peercast."
	einfo
	einfo "You can also run 'rc-update add peercast default' to make Peercast"
	einfo "start at boot."

	use amd64 >/dev/null && (
		einfo
		einfo "Also make sure you have 'IA32 Emulation' enabled in your kernel!"
	)

	einfo
	einfo
}

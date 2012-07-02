# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/hashcat-bin/hashcat-bin-0.39.ebuild,v 1.2 2012/07/02 01:19:04 zerochaos Exp $

EAPI=4

MY_P="hashcat-${PV}"

inherit eutils pax-utils
DESCRIPTION="An multi-threaded multihash cracker"
HOMEPAGE="http://hashcat.net/hashcat/"

SRC_URI="http://hashcat.net/files/${MY_P}.7z"

#license applies to this version per http://hashcat.net/forum/thread-1348.html
LICENSE="hashcat"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/p7zip"

S="${WORKDIR}/${MY_P}"

RESTRICT="strip"
QA_PREBUILT="hashcat-cli*.bin"

src_install() {
	dodoc docs/*
	rm -rf *.exe docs
	use x86 && rm hashcat-cli64.bin
	use amd64 && rm hashcat-cli32.bin

	#I assume this is needed but I didn't check
	pax-mark m hashcat-cli*.bin

	insinto /opt/${PN}
	doins -r "${S}"/*

	dodir /usr/bin
	if [ -f "${ED}"/opt/${PN}/hashcat-cli32.bin ]
	then
		fperms +x /opt/${PN}/hashcat-cli32.bin
		echo '#! /bin/sh' > "${ED}"/usr/bin/hashcat-cli32.bin
		echo 'cd /opt/hashcat-bin' >> "${ED}"/usr/bin/hashcat-cli32.bin
		echo 'echo "Warning: hashcat-cli32.bin is running from $(pwd) so be careful of relative paths."' >> "${ED}"/usr/bin/hashcat-cli32.bin
		echo './hashcat-cli32.bin $@' >> "${ED}"/usr/bin/hashcat-cli32.bin
		fperms +x /usr/bin/hashcat-cli32.bin
	fi
	if [ -f "${ED}"/opt/${PN}/hashcat-cli64.bin ]
	then
		fperms +x /opt/${PN}/hashcat-cli64.bin
		echo '#! /bin/sh' > "${ED}"/usr/bin/hashcat-cli64.bin
		echo 'cd /opt/hashcat-bin' >> "${ED}"/usr/bin/hashcat-cli64.bin
		echo 'echo "Warning: hashcat-cli64.bin is running from $(pwd) so be careful of relative paths."' >> "${ED}"/usr/bin/hashcat-cli64.bin
		echo './hashcat-cli64.bin $@' >> "${ED}"/usr/bin/hashcat-cli64.bin
		fperms +x /usr/bin/hashcat-cli64.bin
	fi
}

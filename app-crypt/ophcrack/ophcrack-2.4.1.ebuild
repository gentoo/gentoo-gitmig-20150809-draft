# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ophcrack/ophcrack-2.4.1.ebuild,v 1.2 2008/12/07 18:22:17 ikelos Exp $

inherit toolchain-funcs eutils

BKHIVE_VER="1.1.1"
SAMDUMP_VER="1.1.1"

DESCRIPTION="A time-memory-trade-off-cracker"
HOMEPAGE="http://ophcrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/bkhive-${BKHIVE_VER}.tar.gz
	mirror://sourceforge/${PN}/samdump2-${SAMDUMP_VER}.tar.gz
	!ophsmall? ( http://lasecwww.epfl.ch/SSTIC04-5k.zip )
	ophsmall? ( http://lasecwww.epfl.ch/SSTIC04-10k.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ophsmall"

DEPEND="app-arch/unzip
		>=dev-util/pkgconfig-0.22
		dev-libs/openssl
		net-libs/netwib
		>=x11-libs/gtk+-2"
RDEPEND="dev-libs/openssl
		 net-libs/netwib
		 >=x11-libs/gtk+-2"

src_compile() {
	# Make samdump2
	einfo "Compiling samdump2"
	cd "${WORKDIR}/samdump2-${SAMDUMP_VER}"
	emake -j1 || die "Failed to make samdump"

	# Make bkhive2
	einfo "Compiling bkhive"
	cd "${WORKDIR}/bkhive-${BKHIVE_VER}"
	emake -j1 || die "Failed to make bkhive2"

	# Make the program
	einfo "Compiling ophcrack"
	cd "${S}"
	econf
	emake || die "Failed to make ophcrack"

	# Don't try to install the prebuilt binaries,
	# they'll cause an access violation
	rm -fr "${S}/linux_tools"
}

src_install() {
	make install DESTDIR="${D}"

	cd "${WORKDIR}/bkhive-${BKHIVE_VER}"
	make install DESTDIR="${D}" PREFIX=/usr/

	cd "${WORKDIR}/samdump2-${SAMDUMP_VER}"
	make install DESTDIR="${D}" PREFIX=/usr/

	TABLENAME="5000"
	use ophsmall && TABLENAME="10000"

	dodir "/usr/share/${PN}/${TABLENAME}"
	mv "${WORKDIR}/table"* "${D}/usr/share/${PN}/${TABLENAME}"
}

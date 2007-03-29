# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ophcrack/ophcrack-2.3.3.ebuild,v 1.4 2007/03/29 20:27:50 welp Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A time-memory-trade-off-cracker"
HOMEPAGE="http://ophcrack.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	mirror://sourceforge/${PN}/bkhive2.tar.gz
	http://www.studenti.unina.it/~ncuomo/syskey/samdump2_linux.tgz
	!ophsmall? ( http://lasecwww.epfl.ch/SSTIC04-5k.zip )
	ophsmall? ( http://lasecwww.epfl.ch/SSTIC04-10k.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ophsmall"

DEPEND="app-arch/unzip
		dev-libs/openssl
		net-libs/netwib"
RDEPEND=""

src_unpack() {
	unpack ${A/samdump2_linux.tgz/}
	cd ${S}

	mkdir ${WORKDIR}/samdump2
	pushd ${WORKDIR}/samdump2
	unpack samdump2_linux.tgz
	sed -i -e 's!!!' makedes

	popd
	epatch ${FILESDIR}/${P}-linuxtools-install-path.patch
}

src_compile() {
	# Make samdump2
	einfo "Compiling samdump2"
	cd ${WORKDIR}/samdump2
	MAKEOPTS="-j1" emake || die "Failed to make samdump"

	# Make bkhive2
	einfo "Compiling bkhive2"
	cd ${WORKDIR}/bkhive2
	$(tc-getCXX) ${CXXFLAGS} -lstdc++ -o bkhive2 *.cpp || die "Failed to make bkhive2"

	# Make the program
	einfo "Compiling ophcrack"
	cd ${S}
	econf
	emake || die "Failed to make ophcrack"

	# Copy samdump over
	cp ${WORKDIR}/samdump2/samdump2 ${S}/linux_tools
	cp ${WORKDIR}/bkhive2/bkhive2 ${S}/linux_tools
}

src_install() {
	make install DESTDIR=${D}

	TABLENAME="5000"
	use ophsmall && TABLENAME="10000"

	dodir /usr/share/${PN}/${TABLENAME}
	mv ${WORKDIR}/table* ${D}/usr/share/${PN}/${TABLENAME}
}

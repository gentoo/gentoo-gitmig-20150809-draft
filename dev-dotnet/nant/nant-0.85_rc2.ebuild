# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/nant/nant-0.85_rc2.ebuild,v 1.1 2005/03/16 18:52:38 latexer Exp $

inherit mono eutils

MY_P=${P/_rc/-rc}

DESCRIPTION=".NET build tool"
HOMEPAGE="http://nant.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/mono"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${MY_P}-is-unix.diff || die
	epatch ${FILESDIR}/${MY_P}-profile.diff || die

	# Fix a problem with duplicate building caused by the doc= target
	for file in $(find ${S}/src -name '*.build')
	do
		sed -i "s: doc=.*>:>:" \
			${file}
	done

	# Problem with is-unix() on mono-1.1.x where the platform is detected
	# as !is-unix().
	sed -i -e "s:install-windows, install-linux:install-linux:" \
		-e 's:if.*is-unix()}\"::' \
		${S}/NAnt.build
}

src_compile() {
	emake -j1 || die
}

src_install() {
	make prefix=${D}/usr install || die
	# Fix ${D} showing up in the nant wrapper script, as well as silencing
	# warnings related to the log4net library
	sed -i \
		-e "s:${D}::" \
		-e "2iexport MONO_SILENT_WARNING=1" \
		${D}/usr/bin/nant
	dodoc README.txt
}

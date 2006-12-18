# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/nant/nant-0.85.ebuild,v 1.3 2006/12/18 21:31:01 compnerd Exp $

inherit mono eutils

DESCRIPTION=".NET build tool"
HOMEPAGE="http://nant.sourceforge.net/"
SRC_URI="mirror://sourceforge/nant/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/mono-1.2.2.1"
RDEPEND="${DEPEND}"

# This build is not parallel build friendly
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix a problem with duplicate building caused by the doc= target
	for file in $(find ${S}/src -name '*.build') ; do
		sed -i "s: doc=.*>:>:" ${file}
	done

	# Build against the .NET 2.0 Framework, as it is backwards compatible
	sed -i -e "s/-f:NAnt.build/-t:mono-2.0 -f:NAnt.build/" \
		${S}/Makefile || die "sed failed"
}

src_compile() {
	# PPC Build Workaround
	if [[ ${ARCH} == "ppc" ]] ; then
		export MONO_NO_UNLOAD=1
	fi

	emake || die
}

src_install() {
	make prefix="${D}/usr" install || die "install failed"

	# Fix ${D} showing up in the nant wrapper script, as well as silencing
	# warnings related to the log4net library
	sed -i \
		-e "s:${D}::" \
		-e "2iexport MONO_SILENT_WARNING=1" \
		${D}/usr/bin/nant

	dodoc README.txt
}

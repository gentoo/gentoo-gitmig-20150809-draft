# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/NaturalDocs/NaturalDocs-1.22-r1.ebuild,v 1.6 2004/11/12 18:19:26 blubb Exp $

DESCRIPTION="Extensible, multi-language source code documentation generator"
HOMEPAGE="http://www.naturaldocs.org/"
SRC_URI="mirror://sourceforge/naturaldocs/${P}.zip mirror://sourceforge/naturaldocs/${P}-Patch-3.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"

IUSE=""
RESTRICT="nomirror"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

src_unpack() {
	mkdir ${P} || die "could not create directory ${P}"
	cd ${P}
	unzip ${DISTDIR}/${P}.zip

	# See if we have a patch. If we have more than one, use the highest-
	# numbered one *only*
	local patch=`ls -r ${DISTDIR}/${P}-Patch-?.zip | head -n -1`

	# If we have a patch, it is actually a whole new Perl module. Just
	# unzip it over top of the original one.
	if [ -n "${patch}" ]; then
		einfo Applying patch: `basename ${patch}`
		unzip -o ${patch}
	fi
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	# Install Perl script, modules, and other supporting stuff
	dodir /usr/share/NaturalDocs
	cp -a NaturalDocs ${D}/usr/share/NaturalDocs/
	cp -ar Modules Project Styles ${D}/usr/share/NaturalDocs/

	# Make the Perl script executable
	chmod a+x ${D}/usr/share/NaturalDocs/NaturalDocs

	# Symlink the Perl script into /usr/bin
	dodir /usr/bin
	dosym /usr/share/NaturalDocs/NaturalDocs /usr/bin/NaturalDocs

	# Documentation
	dodoc *.txt
	dohtml -r Help/*
}

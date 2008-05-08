# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-docs/linux-docs-2.4.32.ebuild,v 1.7 2008/05/08 12:24:12 mpagano Exp $

inherit toolchain-funcs

MY_P=linux-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Developer documentation generated from the Linux kernel"
HOMEPAGE="http://www.kernel.org/"
SRC_URI="mirror://kernel/pub/linux/kernel/v2.4/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc sparc ~x86"

IUSE="html"
DEPEND="app-text/docbook-sgml-utils
		dev-lang/perl
		sys-apps/sed
		html? ( media-gfx/xfig )"
RDEPEND=""

src_unpack() {
	unpack ${A}

	sed -i \
		-e "s:db2:docbook2:g" \
		-e "s:docbook2html \$<:docbook2html -o \$@ \$<:" \
		"${S}"/Documentation/DocBook/Makefile
}

src_compile() {
	local ARCH=$(tc-arch-kernel)

	make mandocs || die "make mandocs failed"

	if use html; then
		make htmldocs || die "make htmldocs failed"
	fi
}

src_install() {
	local file

	doman Documentation/man/*

	if use html; then
		for file in Documentation/DocBook/*.sgml; do
			dohtml -r ${file/\.sgml/}
		done
	fi
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/esmall/esmall-0.0.1.20030629.ebuild,v 1.1 2003/06/29 19:32:41 vapier Exp $

inherit enlightenment

DESCRIPTION="scripting language for use internally in enlightenment"
HOMEPAGE="http://www.enlightenment.org/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"

S=${WORKDIR}/${PN}

src_compile() {
	if [ "${ARCH}" == "ppc" ] ; then
		for f in `grep sys/io src/* -l` ; do
			cp ${f}{,.old}
			sed -e 's:sys/io:asm/io:' ${f}.old > ${f}
		done
	fi

	cp autogen.sh{,.old}
	sed -e 's:.*configure.*::' autogen.sh.old > autogen.sh
	env WANT_AUTOCONF_2_5=1 ./autogen.sh || die "could not autogen"

	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	insinto /usr/share/${PN}/include
	doins include/*
	insinto /usr/share/${PN}/examples
	doins examples/*
	find ${D} -name CVS -type d -exec rm -rf '{}' \;
	dodoc AUTHORS NEWS README
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/esmall/esmall-0.0.1.20031013.ebuild,v 1.3 2004/03/14 02:40:38 mr_bones_ Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="scripting language for use internally in enlightenment"

src_compile() {
	if [ "${ARCH}" == "ppc" ] || [ "${ARCH}" == "sparc" ] ; then
		for f in `grep sys/io src/* -l` ; do
			cp ${f}{,.old}
			sed -e 's:sys/io:asm/io:' ${f}.old > ${f}
		done
	fi
	enlightenment_src_compile
}

src_install() {
	enlightenment_src_install
	insinto /usr/share/${PN}/include
	doins include/*
	insinto /usr/share/${PN}/examples
	doins examples/*
}

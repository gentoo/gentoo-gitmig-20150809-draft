# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Ollie Rutherfurd <oliver@rutherfurd.net>
# Maintainer: Jon Nelson <jnelson@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/optik/optik-1.3.ebuild,v 1.1 2002/04/28 17:18:23 jnelson Exp $

S="${WORKDIR}/Optik-${PV}"

DESCRIPTION="Optik is a powerful, flexible, easy-to-use command-line parsing library for Python."
SRC_URI="http://prdownloads.sourceforge.net/optik/Optik-${PV}.tar.gz"
HOMEPAGE="http://optik.sourceforge.net/"

DEPEND="virtual/python"
RDEPEND="${DEPEND}"

src_compile() {
	python setup.py build || die
}

src_install () {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc *.txt examples/*
}

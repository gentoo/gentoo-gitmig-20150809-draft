# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/todo-manager-bronze/todo-manager-bronze-20020807.ebuild,v 1.3 2003/09/05 12:10:36 msterret Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="A task manager."
SRC_URI="mirror://sourceforge/todo-manager/${P}.tar.gz"
HOMEPAGE="http://todo-manager.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/python
	dev-lang/tk"

inherit distutils

src_foo() {

	dodoc AUTHORS.txt ChangeLog.txt LICENSE.txt PKG-INFO README.txt TODO.txt
	dohtml doc/*
}

src_compile() {
	python setup.py clean || die
	distutils_src_compile
}

src_install() {
	exeinto /opt/todo-manager
	doexe   todo-manager

	insinto /opt/todo-manager
	doins __init__.py controls.py interface.py main.py objectlistbox.py \
		setup.py tdm_calendar.py tdmcalls.py tk_options	\
		todo-manager.py todo-manager.pyw

	insinto /opt/todo-manager/plugins
	cd plugins
	doins __init__.py plg_standard.py plugin.py
	cd ..

	insinto /etc/env.d
	doins ${FILESDIR}/97todomanager

	dodoc docs/*.txt AUTHORS.txt ChangeLog.txt LICENSE.txt PKG-INFO README.txt TODO.txt
	dohtml docs/*.html
}

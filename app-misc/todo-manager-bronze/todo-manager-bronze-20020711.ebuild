# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/todo-manager-bronze/todo-manager-bronze-20020711.ebuild,v 1.3 2002/09/20 03:06:26 vapier Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="A task manager."
SRC_URI="mirror://sourceforge/todo-manager/${P}.tar.gz"
HOMEPAGE="http://todo-manager.sourceforge.net"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="dev-lang/python
	dev-lang/tk"

src_compile() {
	python setup.py clean || die
	python setup.py build || die
}

src_install() {
	dodir /opt/todo-manager
	dodir /opt/todo-manager/plugins
	insinto /opt/todo-manager
	doins __init__.py controls.py interface.py main.py objectlistbox.py setup.py tdm_calendar.py tdmcalls.py tk_options	todo-manager todo-manager.py todo-manager.pyw
	insinto /opt/todo-manager/plugins
	doins __init__.py plg_standard.py plugin.py
	
	insinto /etc/env.d
	doins ${FILESDIR}/97todomanager
	
	dodoc AUTHORS.txt ChangeLog.txt LICENSE.txt PKG-INFO README.txt TODO.txt
	dohtml doc/*
}

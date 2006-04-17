# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/taskjuggler/taskjuggler-2.2.0.ebuild,v 1.2 2006/04/17 12:19:09 dertobi123 Exp $

inherit eutils qt3

DESCRIPTION="project management tool for Linux and UNIX system-based operating systems"
SRC_URI="http://www.taskjuggler.org/download/${P}.tar.bz2"
HOMEPAGE="http://taskjuggler.org"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="arts kde"
SLOT="0"

# Otherwise compilation will break for amd64 or when using -Os
DEPEND=">=x11-libs/qt-3.3
	kde? ( >=kde-base/kdelibs-3
		|| ( kde-base/libkdepim kde-base/kdepim  )
		|| ( kde-base/libkcal kde-base/kdepim ) )
	app-text/openjade
	dev-libs/libxslt
	>=dev-perl/Class-MethodMaker-2.02
	dev-perl/Date-Calc
	dev-perl/PostScript-Simple
	dev-perl/XML-Parser
	net-print/poster"

#src_unpack() {
#	unpack ${A}
#	epatch ${FILESDIR}/${P}-tjx2gantt.diff
#}

src_compile() {
	# 'db2html' does not know '--xencoding utf8' and is called 'docbook2html' in gentoo
	# also 'db2ps --pdf' should be 'docbook2pdf' and 'db2ps' should be 'docbook2ps'
	# see http://lists.suse.com/archive/taskjuggler-devel/2005-Mar/0011.html
	sed -i -e 's/--xencoding utf-8//g' docs/en/Makefile.*
	sed -i -e 's/db2ps --pdf/docbook2pdf/g' docs/en/Makefile.*
	sed -i -e 's/db2ps/docbook2ps/g' docs/en/Makefile.*

	# Need to fake out QT or we'll get sandbox probles 
	# from http://www.gentoo.org/cgi-bin/viewcvs.cgi/dev-db/tora/tora-1.3.13.ebuild?r1=1.2&r2=1.3
	REALHOME="$HOME"
	mkdir -p $T/fakehome/.kde
	mkdir -p $T/fakehome/.qt
	export HOME="$T/fakehome"
	addwrite "${QTDIR}/etc/settings"

	local myconf
	myconf="--with-kde-support"
	use kde \
		&& myconf="${myconf}=yes" \
		|| myconf="${myconf}=no"

	myconf="${myconf} `use_with arts`"

	econf \
		${myconf} \
		|| die "configure failed"

	# don't build docs, fails in docbook2html and docbook2pdf...
	sed -i -e 's/ docs / /g' Makefile

	emake || die "emake failed"
}

src_install() {
#	dodir /usr/share/apps/katepart/syntax
#	doins Contrib/kate/taskjuggler.xml || die
	make install DESTDIR=${D} || die "install failed"
	use kde && \
		cd Contrib/kate && \
		make install DESTDIR=${D} || die "install kate-addons failed"
}


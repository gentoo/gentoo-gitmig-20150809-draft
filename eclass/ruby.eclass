# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ruby.eclass,v 1.2 2003/09/07 03:09:26 agriffis Exp $
#
# Author: Mamoru KOMACHI <usata@gentoo.org>
#
# The ruby eclass is designed to allow easier installation of ruby
# softwares, and their incorporation into the Gentoo Linux system.

ECLASS=ruby
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS src_compile src_install

HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=${PN}"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="Ruby"

newdepend ">=dev-lang/ruby-1.6.8"

ruby_src_compile() {
	if [ -f extconf.rb ] ; then
		ruby extconf.rb || die "extconf.rb failed"
		emake || die "make failed"
	elif [ -f install.rb ] ; then
		ruby install.rb config --prefix=/usr \
			|| die "insall.rb config failed"
		ruby install.rb setup \
			|| die "install.rb setup failed"
	elif [ -f configure ] ; then
		econf || die "econf failed"
		emake || die "emake failed"
	elif [ -f Makefile ] ; then
		emake || die "emake failed"
	fi
}

ruby_src_install() {
	local siteruby rdbase=/usr/share/doc/${PF}/rd

	if [ -f extconf.rb -o -f Makefile ] ; then
		einstall DESTDIR=${D} || die "einstall failed"
	elif [ -f install.rb ] ; then
		ruby install.rb config --prefix=${D}/usr \
			|| die "install.rb config failed"
		ruby install.rb install \
			|| die "install.rb install failed"
	else
		siteruby=$(ruby -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')
		insinto ${siteruby}/${PN}
		doins *.rb || "doins failed"
	fi

	insinto ${rdbase}
	find . -name '*.rd*' | xargs doins
	rmdir --ignore-fail-on-non-empty ${D}${rdbase}
	if [ -d doc -o -d docs -o examples ] ; then
		dohtml -r doc/* docs/* examples/*
	else
		dohtml -r *
	fi
	if [ -d sample ] ; then
		dodir /usr/share/doc/${PF}
		cp -a sample ${D}/usr/share/doc/${PF} || "cp failed"
	fi
	dodoc ChangeLog* [A-Z][A-Z]*
}

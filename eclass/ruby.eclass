# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ruby.eclass,v 1.6 2003/10/12 17:35:00 usata Exp $
#
# Author: Mamoru KOMACHI <usata@gentoo.org>
#
# The ruby eclass is designed to allow easier installation of ruby
# softwares, and their incorporation into the Gentoo Linux system.

ECLASS=ruby
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS erubyconf erubymake erubyinstall \
	src_unpack src_compile src_install

HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=${PN}"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="Ruby"

newdepend ">=dev-lang/ruby-1.6.8"
if [ "${WANT_RUBY_1_6}" ] ; then
	alias ruby=ruby16
elif [ "${WANT_RUBY_1_8}" ] ; then
	alias ruby=ruby18
fi
if has_version '=dev-lang/ruby-1.6*' ; then
	USE_RUBY_1_6=1
fi
if has_version '=dev-lang/ruby-1.8*' ; then
	USE_RUBY_1_8=1
fi

ruby_src_unpack() {
	if [ "${USE_RUBY_1_6}" -a "${USE_RUBY_1_8}" ] && \
		[ ! "${WANT_RUBY_1_6}" -a ! "${WANT_RUBY_1_8}" ] ; then
		mkdir -p ${S}/{1.6,1.8}
		cd ${S}/1.6; unpack ${A}; cd -
		cd ${S}/1.8; unpack ${A}; cd -
	else
		unpack ${A}
	fi
}

erubyconf() {
	local RUBY
	if [ "$1" = ruby16 ] ; then
		RUBY=ruby16
	elif [ "$1" = ruby18 ] ; then
		RUBY=ruby18
	else
		RUBY=ruby
	fi

	if [ -f extconf.rb ] ; then
		${RUBY} extconf.rb || die "extconf.rb failed"
	elif [ -f install.rb ] ; then
		${RUBY} install.rb config --prefix=/usr \
			|| die "install.rb config failed"
		${RUBY} install.rb setup \
			|| die "install.rb setup failed"
	elif [ -f configure ] ; then
		econf --with-ruby=${RUBY} || die "econf failed"
	fi
}

erubymake() {
	if [ -f Makefile ] ; then
		emake || die "emake failed"
	fi
}

ruby_src_compile() {

	if [ "${USE_RUBY_1_6}" -a "${USE_RUBY_1_8}" ] && \
		[ ! "${WANT_RUBY_1_6}" -a ! "${WANT_RUBY_1_8}" ] ; then
		einfo "src_compiling for ruby 1.6 ;)"
		cd 1.6/${S#${WORKDIR}}
		erubyconf ruby16 || die
		erubymake || die
		cd -
		einfo "src_compiling for ruby 1.8 ;)"
		cd 1.8/${S#${WORKDIR}}
		erubyconf ruby18 || die
		erubymake || die
		cd -
	else
		einfo "src_compiling ;)"
		erubyconf || die
		erubymake || die
	fi
}

erubyinstall() {
	local RUBY
	if [ "$1" = ruby16 ] ; then
		RUBY=ruby16
	elif [ "$1" = ruby18 ] ; then
		RUBY=ruby18
	else
		RUBY=ruby
	fi

	if [ -f install.rb ] ; then
		${RUBY} install.rb config --prefix=${D}/usr \
			|| die "install.rb config failed"
		${RUBY} install.rb install \
			|| die "install.rb install failed"
	elif [ -f extconf.rb -o -f Makefile ] ; then
		einstall DESTDIR=${D} || die "einstall failed"
	else
		if [ "${WANT_RUBY_1_6}" -o "${WANT_RUBY_1_8}" ] ; then
			siteruby=$(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')
		else
			siteruby=$(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitedir"]')
		fi
		insinto ${siteruby}
		doins *.rb || "doins failed"
	fi
}

ruby_src_install() {
	local siteruby rdbase=/usr/share/doc/${PF}/rd

	if [ "${USE_RUBY_1_6}" -a "${USE_RUBY_1_8}" ] && \
		[ ! "${WANT_RUBY_1_6}" -a ! "${WANT_RUBY_1_8}" ] ; then
		einfo "src_installing for ruby 1.6 ;)"
		cd ${S}/1.6/${S#${WORKDIR}}
		erubyinstall ruby16
		cd -
		einfo "src_installing for ruby 1.8 ;)"
		cd ${S}/1.8/${S#${WORKDIR}}
		erubyinstall ruby18
		#cd -
	else
		einfo "src_installing ;)"
		erubyinstall
	fi

	einfo "dodoc'ing ;)"
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

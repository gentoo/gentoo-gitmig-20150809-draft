# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ruby.eclass,v 1.10 2003/10/20 12:01:18 usata Exp $
#
# Author: Mamoru KOMACHI <usata@gentoo.org>
#
# The ruby eclass is designed to allow easier installation of ruby
# softwares, and their incorporation into the Gentoo Linux system.

ECLASS=ruby
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS erubyconf erubymake erubyinstall erubydoc \
	src_unpack econf emake src_compile einstall src_install

HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=${PN}"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="Ruby"

newdepend ">=dev-lang/ruby-1.6.8"
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
	shift

	if [ -f configure ] ; then
		./configure \
			--prefix=/usr \
			--host=${CHOST} \
			--mandir=/usr/share/man \
			--infodir=/usr/share/info \
			--datadir=/usr/share \
			--sysconfdir=/etc \
			--localstatedir=/var/lib \
			--with-ruby=${RUBY} \
			${EXTRA_ECONF} \
			$@ || die "econf failed"
	fi
	if [ -f install.rb ] ; then
		${RUBY} install.rb config --prefix=/usr $@ \
			|| die "install.rb config failed"
		${RUBY} install.rb setup $@ \
			|| die "install.rb setup failed"
	fi
	if [ -f extconf.rb ] ; then
		${RUBY} extconf.rb $@ || die "extconf.rb failed"
	fi
}

ruby_econf() {
	if [ "${USE_RUBY_1_6}" -a "${USE_RUBY_1_8}" ] && \
		[ ! "${WANT_RUBY_1_6}" -a ! "${WANT_RUBY_1_8}" ] ; then
		einfo "running econf for ruby 1.6 ;)"
		cd 1.6/${S#${WORKDIR}}
		erubyconf ruby16 $@ || die
		cd -
		einfo "running econf for ruby 1.8 ;)"
		cd 1.8/${S#${WORKDIR}}
		erubyconf ruby18 $@ || die
		cd -
	else
		einfo "running econf for ruby ;)"
		erubyconf ruby $@ || die
	fi
}

erubymake() {
	if [ -f makefiles -o -f GNUmakefile -o -f makefile -o -f Makefile ] ; then
		make $@ || die "emake for ruby failed"
	fi
}

ruby_emake() {
	if [ "${USE_RUBY_1_6}" -a "${USE_RUBY_1_8}" ] && \
		[ ! "${WANT_RUBY_1_6}" -a ! "${WANT_RUBY_1_8}" ] ; then
		einfo "running emake for ruby 1.6 ;)"
		cd 1.6/${S#${WORKDIR}}
		erubymake $@ || die
		cd -
		einfo "running emake for ruby 1.8 ;)"
		cd 1.8/${S#${WORKDIR}}
		erubymake $@ || die
		cd -
	else
		einfo "running emake for ruby ;)"
		erubymake $@ || die
	fi
}

ruby_src_compile() {

	ruby_econf || die
	ruby_emake $@ || die
}

erubyinstall() {
	local RUBY siteruby
	if [ "$1" = ruby16 ] ; then
		RUBY=ruby16
	elif [ "$1" = ruby18 ] ; then
		RUBY=ruby18
	else
		RUBY=ruby
	fi
	shift

	if [ -f install.rb ] ; then
		${RUBY} install.rb config --prefix=${D}/usr $@ \
			|| die "install.rb config failed"
		${RUBY} install.rb install $@ \
			|| die "install.rb install failed"
	elif [ -f extconf.rb -o -f Makefile ] ; then
		make DESTDIR=${D} $@ install || die "make install failed"
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

ruby_einstall() {

	if [ "${USE_RUBY_1_6}" -a "${USE_RUBY_1_8}" ] && \
		[ ! "${WANT_RUBY_1_6}" -a ! "${WANT_RUBY_1_8}" ] ; then
		einfo "running einstall for ruby 1.6 ;)"
		cd ${S}/1.6/${S#${WORKDIR}}
		erubyinstall ruby16 $@
		cd -
		einfo "running einstall for ruby 1.8 ;)"
		cd ${S}/1.8/${S#${WORKDIR}}
		erubyinstall ruby18 $@
		S=${S}/1.8/${S#${WORKDIR}}
		#cd -
	else
		einfo "running einstall for ruby ;)"
		erubyinstall ruby $@
	fi
}

erubydoc() {
	local rdbase=/usr/share/doc/${PF}/rd rdfiles=$(find . -name '*.rd*')

	einfo "running dodoc for ruby ;)"

	insinto ${rdbase}
	[ -n "${rdfiles}" ] && doins ${rdfiles}
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
	for i in ChangeLog* [A-Z][A-Z]* ; do
		[ -e $i ] && dodoc $i
	done
}

ruby_src_install() {

	ruby_einstall $@ || die

	erubydoc
}

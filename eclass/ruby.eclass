# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ruby.eclass,v 1.14 2003/11/15 21:25:51 usata Exp $
#
# Author: Mamoru KOMACHI <usata@gentoo.org>
#
# The ruby eclass is designed to allow easier installation of ruby
# softwares, and their incorporation into the Gentoo Linux system.

# src_unpack, src_compile and src_install call a set of functions to emerge
# ruby with SLOT support; econf, emake and einstall is a wrapper for ruby
# to automate configuration, make and install process (they override default
# econf, emake and einstall defined by ebuild.sh respectively).

# Variables:
# USE_RUBY	Defines which version of ruby is supported.
#		Set it to "0" if it installs only version independent files,
#		and set it to something like "1.6 1.8" if the ebuild supports 
#		both ruby 1.6 and 1.8 but has version depenedent files such
#		as libraries.
# EXTRA_ECONF	You can pass extra arguments to econf by defining this
#		variable. Note that you cannot specify them by command line
#		if you are using <sys-apps/portage-2.0.49-r17.

ECLASS=ruby
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS erubyconf erubymake erubyinstall erubydoc \
	src_unpack econf emake src_compile einstall src_install

HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=${PN}"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="Ruby"

newdepend ">=dev-lang/ruby-1.6.8"
if has_version '=dev-lang/ruby-1.6*' && [[ "${USE_RUBY/1.6/}" != "${USE_RUBY}" ]] ; then
	WITH_RUBY="${WITH_RUBY} 1.6"
fi
if has_version '=dev-lang/ruby-1.8*' && [[ "${USE_RUBY/1.8/}" != "${USE_RUBY}" ]] ; then
	WITH_RUBY="${WITH_RUBY} 1.8"
fi
if has_version '=dev-lang/ruby-1.6*' && has_version '=dev-lang/ruby-1.8*' \
	[[ "${USE_RUBY/0/}" != "${USE_RUBY}" ]] ; then
	WITH_RUBY="0"
fi

ruby_src_unpack() {
	if [[ "${WITH_RUBY/1.6/}" != "${WITH_RUBY}" && "${WITH_RUBY/1.8/}" != "${WITH_RUBY}" ]] ; then
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
	if [[ "${WITH_RUBY/1.6/}" != "${WITH_RUBY}" && "${WITH_RUBY/1.8/}" != "${WITH_RUBY}" ]] ; then
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
	if [[ "${WITH_RUBY/1.6/}" != "${WITH_RUBY}" && "${WITH_RUBY/1.8/}" != "${WITH_RUBY}" ]] ; then
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
	if [ "$1" = ruby16 -a -x /usr/bin/ruby16 ] ; then
		RUBY=ruby16
	elif [ "$1" = ruby18 -a -x /usr/bin/ruby18 ] ; then
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
		if [[ "${WITH_RUBY/1.6/}" != "${WITH_RUBY}" && "${WITH_RUBY/1.8/}" != "${WITH_RUBY}" ]] ; then
			siteruby=$(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')
		else
			siteruby=$(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitedir"]')
		fi
		insinto ${siteruby}
		doins *.rb || "doins failed"
	fi
}

ruby_einstall() {

	local siteruby=$(ruby -r rbconfig -e 'print Config::CONFIG["sitelibdir"]')

	if [[ "${WITH_RUBY/1.6/}" != "${WITH_RUBY}" && "${WITH_RUBY/1.8/}" != "${WITH_RUBY}" ]] ; then
		einfo "running einstall for ruby 1.6 ;)"
		MY_S=${S}/1.6/${S#${WORKDIR}}
		cd ${MY_S}
		erubyinstall ruby16 $@
		einfo "running einstall for ruby 1.8 ;)"
		MY_S=${S}/1.8/${S#${WORKDIR}}
		cd ${MY_S}
		erubyinstall ruby18 $@
		S=${MY_S}
		#cd -
	elif [[ "${WITH_RUBY/0/}" != "${WITH_RUBY}" ]] ; then
		if [ -n "`use ruby18`" ] ; then
			erubyinstall ruby18 $@
			if [ -d ${D}${siteruby}/../1.8 ] ; then
				cd ${D}${siteruby}/../1.8
				dodir ${siteruby}/../1.6
				for x in * ; do
					ln -s ../1.8/$x ../1.6/$x
				done
				cd -
			fi
		else
			erubyinstall ruby16 $@
			if [ -d ${D}${siteruby}/../1.6 ] ; then
				cd ${D}${siteruby}/../1.6
				dodir ${siteruby}/../1.8
				for x in * ; do
					ln -s ../1.6/$x ../1.8/$x
				done
				cd -
			fi
		fi
		erubyinstall
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

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ruby.eclass,v 1.17 2003/12/24 22:14:55 usata Exp $
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
# USE_RUBY	Space delimited list of supported ruby.
#		Set it to "any" if it installs only version independent files.
#		If your ebuild supports both ruby 1.6 and 1.8 but has version
#		depenedent files such as libraries, set it to something like
#		"ruby16 ruby18". Possible values are "any ruby16 shim18 ruby18"
#		Note: USE_RUBY="shim18" doesn't take any effect at the moment.
# WITH_RUBY	Contains space delimited list of installed ruby which is
#		supported (supported ruby should be specified in USE_RUBY).
#		It is automatically defined if your ebuild set DEPEND list
#		correctly, so usually you shouldn't set this variable by hand.
# EXTRA_ECONF	You can pass extra arguments to econf by defining this
#		variable. Note that you cannot specify them by command line
#		if you are using <sys-apps/portage-2.0.49-r17.

ECLASS=ruby
INHERITED="${INHERITED} ${ECLASS}"
EXPORT_FUNCTIONS erubyconf erubymake erubyinstall erubydoc \
	src_unpack econf emake src_compile einstall src_install

inherit eutils

HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=${PN}"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="Ruby"

newdepend ">=dev-lang/ruby-1.6.8"
if has_version '=dev-lang/ruby-1.6*' && [[ "${USE_RUBY/ruby16/}" != "${USE_RUBY}" ]] ; then
	WITH_RUBY="${WITH_RUBY} ruby16"
fi
if has_version '=dev-lang/ruby-1.8*' && [[ "${USE_RUBY/ruby18/}" != "${USE_RUBY}" ]] ; then
	WITH_RUBY="${WITH_RUBY} ruby18"
fi
if has_version '=dev-lang/ruby-1.6*' && has_version '=dev-lang/ruby-1.8*' \
	&& [[ "${USE_RUBY/any/}" != "${USE_RUBY}" ]] ; then
	WITH_RUBY="${WITH_RUBY} any"
fi

ruby_src_unpack() {

	unpack ${A}
	# apply bulk patches
	[[ -n "${PATCHES}" ]] && xpatch "${PATCHES}"

	if [[ "${WITH_RUBY/ruby16/}" != "${WITH_RUBY}" && "${WITH_RUBY/ruby18/}" != "${WITH_RUBY}" ]] ; then
		mkdir ${T}/${S#${WORKDIR}}
		cp -a * ${T}${S#${WORKDIR}}
	fi
}

erubyconf() {
	local RUBY
	if [ "$1" = ruby16 ] ; then
		RUBY=/usr/bin/ruby16
	elif [ "$1" = ruby18 ] ; then
		RUBY=/usr/bin/ruby18
	else
		RUBY=/usr/bin/ruby
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
	if [[ "${WITH_RUBY/ruby16/}" != "${WITH_RUBY}" && "${WITH_RUBY/ruby18/}" != "${WITH_RUBY}" ]] ; then
		einfo "running econf for ruby 1.6 ;)"
		erubyconf ruby16 $@ || die
		einfo "running econf for ruby 1.8 ;)"
		cd ${T}/${S#${WORKDIR}}
		erubyconf ruby18 $@ || die
		cd -
	elif [[ "${WITH_RUBY/ruby16/}" != "${WITH_RUBY}" ]] ; then
		einfo "running econf for ruby 1.6 ;)"
		erubyconf ruby16 $@ || die
	elif [[ "${WITH_RUBY/ruby18/}" != "${WITH_RUBY}" ]] ; then
		einfo "running econf for ruby 1.8 ;)"
		erubyconf ruby18 $@ || die
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
	if [[ "${WITH_RUBY/ruby16/}" != "${WITH_RUBY}" && "${WITH_RUBY/ruby18/}" != "${WITH_RUBY}" ]] ; then
		einfo "running emake for ruby 1.6 ;)"
		erubymake $@ || die
		einfo "running emake for ruby 1.8 ;)"
		cd ${T}/${S#${WORKDIR}}
		erubymake $@ || die
		cd -
	elif [[ "${WITH_RUBY/ruby16/}" != "${WITH_RUBY}" ]] ; then
		einfo "running emake for ruby 1.6 ;)"
		[[ -x /usr/bin/ruby16 ]] && RUBY=ruby16 || RUBY=ruby
		erubymake RUBY=${RUBY} $@
	elif [[ "${WITH_RUBY/ruby18/}" != "${WITH_RUBY}" ]] ; then
		einfo "running emake for ruby 1.8 ;)"
		[[ -x /usr/bin/ruby18 ]] && RUBY=ruby18 || RUBY=ruby
		erubymake RUBY=${RUBY} $@
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
		RUBY=/usr/bin/ruby16
	elif [ "$1" = ruby18 -a -x /usr/bin/ruby18 ] ; then
		RUBY=/usr/bin/ruby18
	else
		RUBY=/usr/bin/ruby
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
		if [[ "${WITH_RUBY/ruby16/}" != "${WITH_RUBY}" && "${WITH_RUBY/ruby18/}" != "${WITH_RUBY}" ]] ; then
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

	if [[ "${WITH_RUBY/ruby16/}" != "${WITH_RUBY}" && "${WITH_RUBY/ruby18/}" != "${WITH_RUBY}" ]] ; then
		einfo "running einstall for ruby 1.6 ;)"
		erubyinstall ruby16 $@
		einfo "running einstall for ruby 1.8 ;)"
		cd ${T}/${S#${WORKDIR}}
		erubyinstall ruby18 $@
		cd -
	elif [[ "${WITH_RUBY/ruby16/}" != "${WITH_RUBY}" ]] ; then
		einfo "running einstall for ruby 1.6 ;)"
		erubyinstall ruby16 $@
	elif [[ "${WITH_RUBY/ruby18/}" != "${WITH_RUBY}" ]] ; then
		einfo "running einstall for ruby 1.8 ;)"
		erubyinstall ruby18 $@
	elif [[ "${WITH_RUBY/any/}" != "${WITH_RUBY}" ]] ; then
		if [ -n "`use ruby16`" ] ; then
			erubyinstall ruby16 $@
			if [ -d ${D}${siteruby}/../1.6 ] ; then
				cd ${D}${siteruby}/../1.6
				dodir ${siteruby}/../1.8
				for x in * ; do
					ln -s ../1.6/$x ../1.8/$x
				done
				cd -
			fi
		else
			erubyinstall ruby18 $@
			if [ -d ${D}${siteruby}/../1.8 ] ; then
				cd ${D}${siteruby}/../1.8
				dodir ${siteruby}/../1.6
				for x in * ; do
					ln -s ../1.8/$x ../1.6/$x
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

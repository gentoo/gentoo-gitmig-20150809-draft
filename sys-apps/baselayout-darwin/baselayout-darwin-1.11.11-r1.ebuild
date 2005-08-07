# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/baselayout-darwin/baselayout-darwin-1.11.11-r1.ebuild,v 1.1 2005/08/07 00:39:17 josejx Exp $

inherit eutils

DESCRIPTION="Baselayout and init scripts (eventually)"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~josejx/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc-macos"
IUSE=""
DEPEND=""
RDEPEND="sys-apps/coreutils-darwin"

PROVIDE="virtual/baselayout"

src_unpack() {
	unpack ${A}
	cd ${S}/etc/
	epatch "${FILESDIR}/dont-destroy-path.patch"
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	local dir libdirs libdirs_env rcscripts_dir

	dodir /etc/env.d
	dodir /etc/init.d

	#
	# Setup files in /etc
	#
	insopts -m0644
	insinto /etc
	doins -r "${S}"/etc/*

	insinto /etc/env.d
	doins ${S}/etc/env.d/*
	insinto /etc/skel
	find ${S}/etc/skel -maxdepth 1 -type f -print0 | xargs -0 doins

	#
	# Setup files in /sbin
	#
	cd ${S}/sbin
	into /
	# These moved from /etc/init.d/ to /sbin to help newb systems
	# from breaking
	dosbin functions.sh

	# Compat symlinks between /etc/init.d and /sbin
	# (some stuff have hardcoded paths)
	dosym /sbin/functions.sh /etc/init.d/functions.sh

	# We can only install new, fast awk versions of scripts
	# if 'build' or 'bootstrap' is not in USE.  This will
	# change if we have sys-apps/gawk-3.1.1-r1 or later in
	# the build image ...
	#if ! use build; then
		# This is for new depscan.sh and env-update.sh
		# written in awk
		#cd ${S}/sbin
		#into /
		#dosbin env-update.sh
		#insinto ${rcscripts_dir}/awk
		#doins ${S}/src/awk/*.awk
	#fi
}

pkg_postinst() {
	if [ -f /etc/profile ] && ! grep profile.gentoo /etc/profile > /dev/null; then
		einfo "Adding /etc/profile.gentoo to /etc/profile"
		echo "source /etc/profile.gentoo" >> /etc/profile
	fi
	if [ -f /etc/bashrc ] && ! grep skel /etc/bashrc > /dev/null; then
		einfo "Adding /etc/skel/.bashrc to /etc/bashrc"
		echo ". /etc/skel/.bashrc" >> /etc/bashrc
	fi

	echo
	einfo "Please be sure to update all pending '._cfg*' files in /etc,"
	einfo "else things might break at your next reboot!  You can use 'etc-update'"
	einfo "to accomplish this:"
	einfo
	einfo "  # etc-update"
	echo
}

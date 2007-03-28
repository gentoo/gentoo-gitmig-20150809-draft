# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/puppet/puppet-0.22.3.ebuild,v 1.1 2007/03/28 14:22:10 nakano Exp $

inherit eutils ruby

DESCRIPTION="A system automation and configuration management software"
LICENSE="GPL-2"
HOMEPAGE="http://reductivelabs.com/projects/puppet/index.html"
SRC_URI="http://reductivelabs.com/downloads/${PN}/${P}.tgz"
RDEPEND=">=dev-ruby/facter-1.3.5 >=app-portage/eix-0.7.9"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~amd64"

USE_RUBY="ruby18"

pkg_setup() {
	built_with_use virtual/ruby ipv6 || \
		die "Ruby must be built with ipv6 support, otherwise puppet will not be able to run"

	enewgroup puppet || die "Problem creating group puppet"
	enewuser puppet -1 -1 /var/lib/puppet puppet || die "Problem creating user puppet"
}

src_compile() {
	DESTDIR=${D} ruby_econf || die
	DESTDIR=${D} ruby_emake "$@" || die
}

src_install() {
	DESTDIR=${D} ruby_einstall "$@" || die
	DESTDIR=${D} erubydoc

	# Installation of init scripts and configuration
	doinitd ${S}/conf/gentoo/init.d/puppetmaster
	doconfd ${S}/conf/gentoo/conf.d/puppetmaster
	doinitd ${S}/conf/gentoo/init.d/puppet
	doconfd ${S}/conf/gentoo/conf.d/puppet


	# Initial configuration files
	dodir /etc/puppet/manifests
	insinto /etc/puppet
	doins ${S}/conf/gentoo/puppet/*

	# Location of log and data files
	dodir /var/log/puppet
	dodir /var/lib/puppet
	keepdir /var/run/puppet
}

pkg_postinst() {
	ewarn "Please, *don't* include the --ask option in EMERGE_EXTRA_OPTS as this could cause puppet to hang"
	ewarn "while installing packages."
	ewarn
	ewarn "Puppet uses eix to get information about currently installed	packages, so please keep the eix"
	ewarn "metadata cache updated so puppet is able to properly handle package installations."
	ewarn
	ewarn "Currently puppet only supports adding and removing services to the default runlevel, if you"
	ewarn "want to add/remove a service from another runlevel you may do so using symlinking."
}

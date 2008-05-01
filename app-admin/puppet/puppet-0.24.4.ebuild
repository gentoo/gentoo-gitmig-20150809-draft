# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/puppet/puppet-0.24.4.ebuild,v 1.2 2008/05/01 19:10:13 dertobi123 Exp $

inherit elisp-common eutils ruby

DESCRIPTION="A system automation and configuration management software"
HOMEPAGE="http://reductivelabs.com/projects/puppet/index.html"
SRC_URI="http://reductivelabs.com/downloads/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE="emacs vim-syntax"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}
	>=dev-ruby/facter-1.3.5
	>=app-portage/eix-0.9.4"

USE_RUBY="ruby18"

SITEFILE="50${PN}-mode-gentoo.el"

pkg_setup() {
	built_with_use virtual/ruby ipv6 || \
		die "Ruby must be built with ipv6 support, otherwise puppet will not be able to run"

	enewgroup puppet || die "Problem creating group puppet"
	enewuser puppet -1 -1 /var/lib/puppet puppet || die "Problem creating user puppet"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-0.24.2-gentoo.patch
}

src_compile() {
	if use emacs ; then
		elisp-compile ext/emacs/puppet-mode.el || die "elisp-compile failed"
	fi
}

src_install() {
	DESTDIR="${D}" ruby_einstall "$@" || die
	DESTDIR="${D}" erubydoc

	# Installation of init scripts and configuration
	# bug #211910
	#doinitd conf/gentoo/init.d/puppetmaster
	newinitd "${FILESDIR}"/puppetmaster.init puppetmaster
	doconfd conf/gentoo/conf.d/puppetmaster
	doinitd conf/gentoo/init.d/puppet
	doconfd conf/gentoo/conf.d/puppet

	# Initial configuration files
	keepdir /etc/puppet/manifests
	insinto /etc/puppet
	doins conf/gentoo/puppet/*

	# Location of log and data files
	keepdir /var/run/puppet
	keepdir /var/log/puppet
	keepdir /var/lib/puppet/ssl
	keepdir /var/lib/puppet/files
	fowners -R puppet:puppet /var/{run,log,lib}/puppet

	if use emacs ; then
		elisp-install ${PN} ext/emacs/puppet-mode.el* || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/syntax; doins ext/vim/syntax/puppet.vim
		insinto /usr/share/vim/vimfiles/ftdetect; doins	ext/vim/ftdetect/puppet.vim
	fi

	# ext and examples files
	for f in $(find ext examples -type f) ; do
		docinto $(dirname ${f})
		dodoc ${f}
	done
}

pkg_postinst() {
	elog
	elog "Please, *don't* include the --ask option in EMERGE_EXTRA_OPTS as this could"
	elog "cause puppet to hang while installing packages."
	elog
	elog "Puppet uses eix to get information about currently installed	packages,"
	elog "so please keep the eix metadata cache updated so puppet is able to properly"
	elog "handle package installations."
	elog
	elog "Currently puppet only supports adding and removing services to the default"
	elog "runlevel, if you want to add/remove a service from another runlevel you may"
	elog "do so using symlinking."
	elog

	if [ \
		-f "${ROOT}/etc/puppet/puppetd.conf" -o \
		-f "${ROOT}/etc/puppet/puppetmaster.conf" -o \
		-f "${ROOT}/etc/puppet/puppetca.conf" \
	] ; then
		elog
		elog "Please remove deprecated config files."
		elog "	/etc/puppet/puppetca.conf"
		elog "	/etc/puppet/puppetd.conf"
		elog "	/etc/puppet/puppetmasterd.conf"
		elog
	fi
	use emacs && elisp-site-regen
}
pkg_postrm() {
	use emacs && elisp-site-regen
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/puppet/puppet-2.7.1.ebuild,v 1.1 2011/06/29 17:44:07 matsuu Exp $

EAPI="3"
# ruby19: dev-ruby/ruby-ldap has no ruby19
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="test"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG* README*"

inherit elisp-common xemacs-elisp-common eutils ruby-fakegem

DESCRIPTION="A system automation and configuration management software"
HOMEPAGE="http://puppetlabs.com/"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="augeas diff doc emacs ldap rrdtool selinux shadow sqlite3 vim-syntax xemacs"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"

ruby_add_rdepend "
	>=dev-ruby/facter-1.5.1
	augeas? ( dev-ruby/ruby-augeas )
	diff? ( dev-ruby/diff-lcs )
	doc? ( dev-ruby/rdoc )
	ldap? ( dev-ruby/ruby-ldap )
	shadow? ( dev-ruby/ruby-shadow )
	sqlite3? ( dev-ruby/sqlite3-ruby )
	virtual/ruby-ssl"
#	couchdb? ( dev-ruby/couchrest )
#	mongrel? ( www-servers/mongrel )
#	rack? ( >=dev-ruby/rack-1 )
#	rails? (
#		dev-ruby/rails
#		>=dev-ruby/activerecord-2.1
#	)
#	stomp? ( dev-ruby/stomp )

DEPEND="${DEPEND}
	emacs? ( virtual/emacs )
	xemacs? ( app-editors/xemacs )"
RDEPEND="${RDEPEND}
	emacs? ( virtual/emacs )
	xemacs? ( app-editors/xemacs )
	rrdtool? ( >=net-analyzer/rrdtool-1.2.23[ruby] )
	selinux? ( sys-libs/libselinux[ruby] )
	>=app-portage/eix-0.18.0"

SITEFILE="50${PN}-mode-gentoo.el"

pkg_setup() {
	enewgroup puppet
	enewuser puppet -1 -1 /var/lib/puppet puppet
}

all_ruby_compile() {
	all_fakegem_compile

	if use emacs ; then
		elisp-compile ext/emacs/puppet-mode.el || die "elisp-compile failed"
	fi

	if use xemacs ; then
		# Create a separate version for xemacs to be able to install
		# emacs and xemacs in parallel.
		mkdir ext/xemacs || die
		cp ext/emacs/* ext/xemacs/ || die
		xemacs-elisp-compile ext/xemacs/puppet-mode.el || die "xemacs-elisp-compile failed"
	fi
}

each_fakegem_install() {
	${RUBY} install.rb --destdir="${D}" install || die
}

all_ruby_install() {
	all_fakegem_install

	newinitd "${FILESDIR}"/puppetmaster.init puppetmaster || die
	doconfd conf/gentoo/conf.d/puppetmaster || die
	newinitd "${FILESDIR}"/puppet.init puppet || die
	doconfd conf/gentoo/conf.d/puppet || die

	# Initial configuration files
	keepdir /etc/puppet/manifests || die
	keepdir /etc/puppet/modules || die
	insinto /etc/puppet

	# Bug #338439
	#doins conf/gentoo/puppet/* || die
	doins conf/redhat/*.conf || die
	doins conf/auth.conf || die

	# Location of log and data files
	keepdir /var/run/puppet || die
	keepdir /var/log/puppet || die
	keepdir /var/lib/puppet/ssl || die
	keepdir /var/lib/puppet/facts || die
	keepdir /var/lib/puppet/files || die
	fowners -R puppet:puppet /var/{run,log,lib}/puppet || die

	if use emacs ; then
		elisp-install ${PN} ext/emacs/puppet-mode.el* || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi

	if use xemacs ; then
		xemacs-elisp-install ${PN} ext/xemacs/puppet-mode.el* || die "xemacs-elisp-install failed"
		xemacs-elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi

	if use ldap ; then
		insinto /etc/openldap/schema; doins ext/ldap/puppet.schema || die
	fi

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/ftdetect; doins ext/vim/ftdetect/puppet.vim || die
		insinto /usr/share/vim/vimfiles/syntax; doins ext/vim/syntax/puppet.vim || die
	fi

	# ext and examples files
	for f in $(find ext examples -type f) ; do
		docinto "$(dirname ${f})"; dodoc "${f}" || die
	done
	docinto conf; dodoc conf/namespaceauth.conf || die
}

pkg_postinst() {
	elog
	elog "Please, *don't* include the --ask option in EMERGE_EXTRA_OPTS as this could"
	elog "cause puppet to hang while installing packages."
	elog
	elog "Puppet uses eix to get information about currently installed packages,"
	elog "so please keep the eix metadata cache updated so puppet is able to properly"
	elog "handle package installations."
	elog
	elog "Currently puppet only supports adding and removing services to the default"
	elog "runlevel, if you want to add/remove a service from another runlevel you may"
	elog "do so using symlinking."
	elog

	if [ \
		-f "${EPREFIX}/etc/puppet/puppetd.conf" -o \
		-f "${EPREFIX}/etc/puppet/puppetmaster.conf" -o \
		-f "${EPREFIX}/etc/puppet/puppetca.conf" \
	] ; then
		elog
		elog "Please remove deprecated config files."
		elog "	/etc/puppet/puppetca.conf"
		elog "	/etc/puppet/puppetd.conf"
		elog "	/etc/puppet/puppetmasterd.conf"
		elog
	fi

	use emacs && elisp-site-regen
	use xemacs && xemacs-elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
	use xemacs && xemacs-elisp-site-regen
}

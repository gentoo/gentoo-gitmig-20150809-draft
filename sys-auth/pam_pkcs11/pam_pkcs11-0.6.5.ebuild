# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_pkcs11/pam_pkcs11-0.6.5.ebuild,v 1.1 2010/10/24 11:05:20 arfrever Exp $

EAPI="3"

inherit autotools eutils multilib pam

DESCRIPTION="PKCS#11 PAM library"
HOMEPAGE="http://www.opensc-project.org/pam_pkcs11"
SRC_URI="http://www.opensc-project.org/files/pam_pkcs11/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="curl ldap pcsc-lite"

RDEPEND="sys-libs/pam
	dev-libs/openssl
	curl? ( net-misc/curl )
	ldap? ( net-nds/openldap )
	pcsc-lite? ( sys-apps/pcsc-lite )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# Fix the example files to be somewhat decent, and usable as
	# default configuration
	sed -i \
		-e '/try_first_pass/s:false:true:' \
		-e '/debug =/s:true:false:' \
		-e "s:/usr/lib:/usr/$(get_libdir):g" \
		etc/pam_pkcs11.conf.example.in \
		etc/pkcs11_eventmgr.conf.example || die "sed failed"

	epatch "${FILESDIR}/${P}-pcsclite_detection.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_with curl) \
		$(use_with pcsc-lite pcsclite) \
		$(use_with ldap) \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" pamdir="$(getpam_mod_dir)" install || die "emake install failed"

	# These are all dlopened plugins, so .la files are useless.
	find "${D}" -name '*.la' -delete || die

	dodoc AUTHORS ChangeLog NEWS README TODO || die

	# Move the make_hash_link script somehwere safe, it's _way_ too
	# generic of a name to use.
	dodir /usr/share/${PN}
	mv "${D}"/usr/bin/make_hash_link.sh "${D}"/usr/share/${PN} || die

	# Provide some basic configuration
	keepdir /etc/pam_pkcs11{,/{cacerts,crl}}

	insinto /etc/pam_pkcs11
	newins etc/pam_pkcs11.conf.example pam_pkcs11.conf || die
	newins etc/pkcs11_eventmgr.conf.example pkcs11_eventmgr.conf || die
}

pkg_config() {
	local dir
	for dir in "${ROOT}"/etc/${PN}/{cacerts,crl}; do
		pushd "${dir}" &> /dev/null
		ebegin "Creating hash links in '${dir}'"
		"${ROOT}"/usr/share/${PN}/make_hash_link.sh || die
		eend $?
		popd &> /dev/null
	done
}

pkg_postinst() {
	elog "You probably want to configure the /etc/${PN}/${PN}.conf file."
	elog "with the settings for your pkcs11 provider."
	elog ""
	elog "You might also want to set up /etc/${PN}/pkcs11_eventmgr.conf"
	elog "with the settings for the event manager, and start it up at"
	elog "user login."
}

# TODO list!
#
# - we need to find a way allow the user to choose whether to start the
#   event manager at _all_ the logins, and if that's the case, lock all
#   kind of sessions (terminal _and_ X);
# - upstream should probably migrate the configuration of the event
#   manager on a per-user basis, since it makes little sense to be _all_
#   system-level configuration;
# - we should probably provide some better config support that ensures
#   the configuration to be valid, as well as creating the symlinks;
# - we should probably add support for nss;
# - we should move the configuration in /etc/security as for the rest
#   of PAM-related configuration.

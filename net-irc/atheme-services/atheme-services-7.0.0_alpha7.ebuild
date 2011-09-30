# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/atheme-services/atheme-services-7.0.0_alpha7.ebuild,v 1.2 2011/09/30 04:47:45 binki Exp $

EAPI=4

inherit eutils flag-o-matic perl-module prefix

MY_P=${P/_/-}

DESCRIPTION="A portable and secure set of open-source and modular IRC services"
HOMEPAGE="http://atheme.net/"
SRC_URI="http://atheme.net/downloads/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~x86-fbsd ~amd64-linux"
IUSE="largenet ldap nls +pcre perl profile ssl"

RDEPEND=">=dev-libs/libmowgli-0.9.95
	ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	perl? ( dev-lang/perl )
	pcre? ( dev-libs/libpcre )
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	# the dependency calculation puts all of the .c files together and
	# overwhelms cc1 with this flag :-(
	filter-flags -combine

	if use profile; then
		# bug #371119
		ewarn "USE=\"profile\" is incompatible with the hardened profile's -pie flag."
		ewarn "Disabling PIE. Please ignore any warning messages about -nopie being invalid."
		append-flags -nopie
	fi

	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/atheme ${PN}
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-mowgli-strl.patch \
		"${FILESDIR}"/${P}-xmlrpc-mowgli-string.patch

	# fix docdir
	sed -i -e 's/\(^DOCDIR.*=.\)@DOCDIR@/\1@docdir@/' extra.mk.in || die

	# basic logging config directive fix
	sed -i -e '/^logfile/s;var/\(.*\.log\);'"${EPREFIX}"'/var/log/atheme/\1;g' dist/* || die

	# QA against bundled libs
	rm -rf libmowgli || die

	# Get useful information into build.log
	sed -i -e '/^\.SILENT:$/d' buildsys.mk.in || die
}

src_configure() {
	econf \
		atheme_cv_c_gcc_w_error_implicit_function_declaration=no \
		--sysconfdir="${EPREFIX}"/etc/${PN} \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--localstatedir="${EPREFIX}"/var \
		--enable-fhs-paths \
		--disable-warnings \
		--enable-contrib \
		$(use_enable largenet large-net) \
		$(use_with ldap) \
		$(use_with nls) \
		$(use_enable profile) \
		$(use_with perl) \
		$(use_with pcre) \
		$(use_enable ssl)
}

src_install() {
	emake DESTDIR="${D}" install

	insinto /etc/${PN}
	for conf in dist/*.example; do
		# The .cron file isn't meant to live in /etc/${PN}, so only
		# install a .example version.
		[[ ${conf} == *cron* ]] && continue

		newins ${conf} $(basename ${conf} .example)
	done

	fowners -R 0:${PN} /etc/${PN}
	keepdir /var/{lib,log}/atheme
	fowners ${PN}:${PN} /var/{lib,log,run}/atheme
	fperms -R go-w,o-rx /etc/${PN}
	fperms 750 /etc/${PN} /var/{lib,log,run}/atheme

	newinitd "${FILESDIR}"/${PN}.initd ${PN}

	# contributed scripts and such:
	insinto /usr/share/doc/${PF}/contrib
	doins contrib/*.{c,pl,php,py,rb}

	if use perl; then
		perlinfo
		insinto "${VENDOR_LIB#${EPREFIX}}"
		doins -r contrib/Atheme{,.pm}
	fi
}

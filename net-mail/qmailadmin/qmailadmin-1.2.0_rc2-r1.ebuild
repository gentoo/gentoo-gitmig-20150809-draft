# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmailadmin/qmailadmin-1.2.0_rc2-r1.ebuild,v 1.1 2004/01/16 06:02:56 robbat2 Exp $

inherit gnuconfig

DESCRIPTION="A web interface for managing a qmail system with virtual domains."
MY_PV="${PV/_rc/-rc}"
MY_P="${PN}-${MY_PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://www.inter7.com/${PN}.html"
RESTRICT="nomirror"
S=${WORKDIR}/${MY_P}

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="net-mail/qmail
		>=net-mail/vpopmail-5.3
		net-mail/autorespond"

RDEPEND="${DEPEND}
		net-www/apache"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
	for i in alias.c auth.c autorespond.c command.c contrib/alias2forward.pl qmailadmin.c template.c user.c; do
		sed -e 's|/Maildir|/.maildir|g' -i ${i}
	done
}

src_compile() {
	local dir_vpopmail="/var/vpopmail"
	local dir_vhost="/var/www/localhost"
	local dir_htdocs="${dir_vhost}/htdocs/${PN}"
	local dir_htdocs_images="${dir_htdocs}/images"
	local url_htdocs_images="/${PN}/images"
	local dir_cgibin="${dir_vhost}/cgi-bin"
	local url_cgibin="/cgi-bin/${PN}"
	local dir_htdocs_htmlib="/usr/share/${PN}/htmllib"
	local dir_qmail="/var/qmail"
	local bin_true="/bin/true"
	local dir_ezmlm="/usr/bin"
	local dir_autorespond="/var/qmail/bin"

	econf ${myopts} \
	--enable-vpopmaildir=${dir_vpopmail} \
	--enable-htmldir=${dir_htdocs} \
	--enable-imageurl=${url_htdocs_images} \
	--enable-imagedir=${dir_htdocs_images} \
	--enable-htmllibdir=${dir_htdocs_htmlib} \
	--enable-qmaildir=${dir_qmail} \
	--enable-true-path=${bin_true} \
	--enable-ezmlmdir=${dir_ezmlm} \
	--enable-cgibindir=${dir_cgibin} \
	--enable-cgipath=${url_cgibin} \
	--enable-autoresponder-path=${dir_autorespond} \
	--enable-domain-autofill \
	--enable-modify-quota \
	--enable-no-cache \
	--enable-maxusersperpage=50 \
	--enable-maxaliasesperpage=50 \
	--enable-vpopuser=vpopmail \
	--enable-vpopgroup=vpopmail \
	|| die "econf failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL README.hooks BUGS TODO CHANGELOG TRANSLATORS COPYING NEWS FAQ README contrib/*
}

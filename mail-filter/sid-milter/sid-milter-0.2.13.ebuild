# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/sid-milter/sid-milter-0.2.13.ebuild,v 1.1 2006/07/18 01:06:48 langthang Exp $

inherit eutils

DESCRIPTION="A milter-based application provide Sender-ID service"

HOMEPAGE="http://sourceforge.net/projects/sid-milter/"

SRC_URI="mirror://sourceforge/sid-milter/${P}.tar.gz"

LICENSE="Sendmail-Open-Source"

SLOT="0"

KEYWORDS="~x86"


IUSE=""

DEPEND="dev-libs/openssl
	>=sys-libs/db-3.2
	mail-filter/libmilter"

S=${WORKDIR}/${P}

pkg_setup() {
	enewgroup milter
	enewuser milter -1 -1 -1 milter
}

src_unpack() {
	unpack "${A}" && cd "${S}"

	# Postfix queue ID patch. See MILTER_README.html#workarounds
	epatch "${FILESDIR}/"${P}-queueID.patch

	confCCOPTS="${CFLAGS}"
	conf_libmilter_INCDIRS="-I/usr/include/libmilter"
	sed -e "s:@@confCCOPTS@@:${confCCOPTS}:" \
		-e "s:@@conf_libmilter_INCDIRS@@:${conf_libmilter_INCDIRS}:" \
		"${FILESDIR}"/site.config.m4 > "${S}"/devtools/Site/site.config.m4 \
		|| die "sed failed"
}

src_install() {
	OBJDIR="obj.`uname -s`.`uname -r`.`arch`"

	dodir /usr/bin /usr/share/man/man8
	make DESTDIR=${D} MANROOT=/usr/share/man/man \
		install -C "${OBJDIR}"/sid-filter \
		|| die "make install failed"
	doman sid-filter/sid-filter.8

	newinitd "${FILESDIR}/sid-filter.init" sid-filter \
		|| die "newinitd failed"
	newconfd "${FILESDIR}/sid-filter.conf" sid-filter \
		|| die "newconfd failed"
}

pkg_postinst() {
	enewgroup milter
	enewuser milter -1 -1 -1 milter
}

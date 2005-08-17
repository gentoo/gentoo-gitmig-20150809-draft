# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/quota/quota-3.12-r1.ebuild,v 1.3 2005/08/17 00:27:50 vapier Exp $

inherit eutils

DESCRIPTION="Linux quota tools"
HOMEPAGE="http://sourceforge.net/projects/linuxquota/"
SRC_URI="mirror://sourceforge/linuxquota/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE="nls tcpd ldap rpc"

RDEPEND="ldap? ( net-nds/openldap )
	tcpd? ( sys-apps/tcp-wrappers )
	rpc? ( net-nds/portmap )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/quota-tools

src_unpack() {
	unpack ${A}
	cd "${S}"

	# patch to prevent quotactl.2 manpage from being installed
	# that page is provided by man-pages instead
	epatch "${FILESDIR}"/${PN}-no-quotactl-manpage.patch

	# Don't strip binaries (from Fedora)
	epatch "${FILESDIR}"/quota-3.06-no-stripping.patch

	sed -i -e "s:,LIBS=\"\$saved_LIBS=\":;LIBS=\"\$saved_LIBS\":" configure
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable ldap ldapmail) \
		$(use_enable rpc) \
		$(use_enable rpc rpcsetquota) \
		|| die
	emake || die
}

src_install() {
	dodir /{sbin,etc,usr/sbin,usr/bin,usr/share/man/man{1,3,8}}
	make ROOTDIR="${D}" install || die
	rm -r "${D}"/usr/include #70938

	insinto /etc
	insopts -m0644
	doins warnquota.conf quotatab

	dodoc doc/*
	dodoc README.*
	dodoc Changelog

	newinitd "${FILESDIR}"/quota.rc6 quota
	newconfd "${FILESDIR}"/quota.confd quota

	if use ldap ; then
		insinto /etc/openldap/schema
		insopts -m0644
		doins ldap-scripts/quota.schema

		exeinto /usr/share/quota/ldap-scripts
		doexe ldap-scripts/*.pl
		doexe ldap-scripts/edquota_editor
	fi
}

pkg_postinst() {
	einfo "with this release, you can configure the used"
	einfo "ports through /etc/services"
	einfo
	einfo "eg. use the default"
	einfo "rquotad               4003/tcp                        # quota"
	einfo "rquotad               4003/udp                        # quota"
}

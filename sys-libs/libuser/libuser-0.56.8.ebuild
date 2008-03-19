# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libuser/libuser-0.56.8.ebuild,v 1.2 2008/03/19 07:29:15 dberkholz Exp $

inherit eutils rpm

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

DESCRIPTION="A user and group account administration library"
HOMEPAGE="https://fedorahosted.org/libuser/"
SRC_URI="mirror://fedora-dev/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ldap sasl selinux quotas"
RDEPEND="=dev-libs/glib-2*
	app-text/linuxdoc-tools
	dev-libs/popt
	sys-libs/pam
	sys-libs/system-config-base
	dev-lang/python
	sys-apps/shadow
	ldap? ( net-nds/openldap )
	sasl? ( dev-libs/cyrus-sasl )"
DEPEND="${RDEPEND}"

src_unpack() {
	rpm_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/0.54.6-raise-minimum-ids-to-1000.patch
}

src_compile() {
	econf \
		$(use_with ldap) \
		$(use_with sasl) \
		$(use_with selinux) \
		$(use_enable quotas quota) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libuser/libuser-0.54.6.ebuild,v 1.2 2006/09/05 20:53:18 dberkholz Exp $

inherit rpm

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="2.1"

DESCRIPTION="A user and group account administration library"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86"
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

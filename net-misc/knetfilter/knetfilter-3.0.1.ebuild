# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/knetfilter/knetfilter-3.0.1.ebuild,v 1.1 2002/05/17 11:52:05 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3

S=${WORKDIR}/${P}
DESCRIPTION="Manage Iptables firewalls with this KDE app"
SRC_URI="http://expansa.sns.it:8080/knetfilter/${P}.tar.gz"
HOMEPAGE="http://expansa.sns.it:8080/knetfilter/"

newdepend ">=sys-apps/iptables-1.2.5"

src_unpack() {
    base_src_unpack
    kde_sandbox_patch ${S}/src
}

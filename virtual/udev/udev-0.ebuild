# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/udev/udev-0.ebuild,v 1.1 2012/11/24 17:52:28 ssuominen Exp $

EAPI=2

DESCRIPTION="Virtual for udev implementation and number of it's features"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="acl gudev hwdb introspection keymap selinux static-libs"

DEPEND=""
RDEPEND="acl? ( || ( >=sys-fs/udev-189[acl] <sys-fs/udev-181 ) )
	static-libs? ( || ( >=sys-fs/udev-189[static-libs] <sys-fs/udev-181 ) )
	|| ( >=sys-fs/udev-171-r9[gudev?,hwdb?,introspection?,keymap?,selinux?] <sys-fs/udev-171 )"

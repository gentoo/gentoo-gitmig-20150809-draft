# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/ezc-TreePersistentObjectTiein/ezc-TreePersistentObjectTiein-1.0.ebuild,v 1.3 2008/01/21 14:39:24 jer Exp $

EZC_BASE_MIN="1.4"
inherit php-ezc

DESCRIPTION="This eZ component uses persistent objects as data storage for the
data elements of the tree nodes of the Tree component."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=dev-php5/ezc-Tree-1.0
	>=dev-php5/ezc-PersistentObject-1.3"

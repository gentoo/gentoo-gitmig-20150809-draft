# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/lyx/lyx-1.1.6.2.ebuild,v 1.4 2001/08/18 14:04:35 danarmak Exp $

# This ebuild simply depends on lyx-base and lyx-utils.

DESCRIPTION="Lyx itself (lyx-base), plus all the utils/packages it can make use of (lyx-utils)."

HOMEPAGE="http://www.lyx.org/"

DEPEND="~app-office/lyx-utils-1.1.6.2
	~app-office/lyx-base-1.1.6.2"
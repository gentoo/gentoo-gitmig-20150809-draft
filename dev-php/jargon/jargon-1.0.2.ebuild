# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/jargon/jargon-1.0.2.ebuild,v 1.4 2005/09/10 13:46:31 sebastian Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Convenience tools built on top of Creole."
HOMEPAGE="http://creole.phpdb.org/wiki/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
SRC_URI="http://creole.phpdb.org/pear/jargon-${PV}.tgz"
RDEPEND=">=dev-php/creole-1.0.2"

need_php5

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-disk-writer/xmms-disk-writer-1.2.10.ebuild,v 1.1 2005/02/12 03:36:13 eradicator Exp $

IUSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=media-sound/xmms-1.2.10"

PLUGIN_PATH="Output/disk_writer"

M4_VER="1.0"

inherit xmms-plugin

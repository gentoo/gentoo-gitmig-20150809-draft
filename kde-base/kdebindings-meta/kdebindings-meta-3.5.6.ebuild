# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-meta/kdebindings-meta-3.5.6.ebuild,v 1.4 2007/01/31 21:47:06 masterdriverz Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdebindings - merge this to pull in all kdebindings-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="java javascript perl python ruby"

# Unslotted packages aren't depended on via deprange
RDEPEND="
$(deprange 3.5.4 $MAXKDEVER kde-base/kalyptus)
$(deprange $PV $MAXKDEVER kde-base/smoke)
java? ( $(deprange $PV $MAXKDEVER kde-base/kdejava)
	$(deprange $PV $MAXKDEVER kde-base/qtjava) )
javascript? ( $(deprange $PV $MAXKDEVER kde-base/kjsembed) )
perl? ( >=kde-base/dcopperl-3.5.0_beta2 )
python? ( >=kde-base/dcoppython-3.5.0_beta2 )
ruby? ( >=kde-base/korundum-$PV
	>=kde-base/qtruby-$PV )"


# Omitted: qtsharp, dcopc, dcopjava, xparts (considered broken by upstream)

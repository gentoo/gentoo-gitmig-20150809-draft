# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gpe-base/libgpewidget/libgpewidget-0.117.ebuild,v 1.1 2009/02/28 23:52:44 solar Exp $

GPE_TARBALL_SUFFIX="bz2"
inherit gpe

DESCRIPTION="A collection of widgets and other common code shared by many GPE applications."

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="${IUSE}"
GPE_DOCS="ChangeLog"

RDEPEND="${RDEPEND} >=x11-libs/gtk+-2.6.3"

DEPEND="${RDEPEND} >=gpe-base/gpe-icons-0.25" # doc? ( >=dev-util/gtk-doc-1.3 )"

# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeutils/kdeutils-3.1_alpha1.ebuild,v 1.2 2002/07/13 09:18:09 danarmak Exp $
inherit kde-dist

DESCRIPTION="${DESCRIPTION}Utilities"

PATCHES="$FILESDIR/kcalc-pow-casts.diff"

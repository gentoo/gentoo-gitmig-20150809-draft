# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-plugins/gkrellm-plugins-1.2.11-r1.ebuild,v 1.1 2002/08/30 01:49:27 seemant Exp $

S=${WORKDIR}/${P//gkrellm-}
DESCRIPTION="emerge this package to install all of the gkrellm plugins"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND=">=app-admin/gkrellm-1.2.11
		>=x11-plugins/gkrellm-bfm-0.5.1
		>=x11-plugins/gkrellm-console-0.1
		>=x11-plugins/gkrellm-mailwatch-0.7.2
		>=x11-plugins/gkrellm-radio-0.3.3
		>=x11-plugins/gkrellm-reminder-0.3.5
		>=x11-plugins/gkrellm-volume-0.8
		>=x11-plugins/gkrellmitime-0.4
		>=x11-plugins/gkrellmlaunch-0.3
		>=x11-plugins/gkrellmms-0.5.6
		>=x11-plugins/gkrellmoon-0.3
		>=x11-plugins/gkrellmouse-0.0.2
		>=x11-plugins/gkrellmwho-0.4
		>=x11-plugins/gkrellmwireless-0.2.2
		>=x11-plugins/gkrellshoot-0.3.11
		>=x11-plugins/gkrellweather-0.2.7-r2
		gnome? ( >=x11-plugins/gkrellm-gnome-0.1 )"

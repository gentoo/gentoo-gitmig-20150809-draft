# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-opengl/ruby-opengl-0.60.0.ebuild,v 1.2 2008/04/07 15:49:00 mr_bones_ Exp $

inherit gems

DESCRIPTION="OpenGL / GLUT bindings for ruby"
HOMEPAGE="http://ruby-opengl.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND=">=dev-ruby/mkrf-0.2.0
	dev-ruby/rake
	virtual/opengl
	virtual/glut"

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://opensource.apple.com/tarballs/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/pmake sys-devel/CoreOSMakefiles sys-devel/pb_makefiles"
RDEPEND="${DEPEND}"

src_compile() {
	pmake MAKEFILEPATH=${EPREFIX}/usr/share \
		MACHINE_ARCH=$(tc-arch) 
}

src_install() {
	pmake MAKEFILEPATH=${EPREFIX}/usr/share \
		install
}
